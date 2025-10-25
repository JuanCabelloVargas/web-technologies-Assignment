class ChallengeRequest < ApplicationRecord
  belongs_to :challenge
  belongs_to :requester, class_name: "User"
  belongs_to :decided_by, class_name: "User", optional: true

  validates :status, presence: true
  validates :requester_id, uniqueness: { scope: :challenge_id }

  after_update :notify_on_status_change, if: :saved_change_to_status?

  private

  def notify_on_status_change
    if status == "approved"
      NotificationService.create_notification(
        user: requester,
        notification_type: "request",
        title: "Your request has been approved",
        body: "Your request to '#{challenge.name}' has been approved.",
        related: self
      )
    elsif status == "rejected"
      NotificationService.create_notification(
        user: requester,
        notification_type: "request",
        title: "Your request has been rejected",
        body: "Your request to '#{challenge.name}' has been rejected.",
        related: self
      )
    end
  end
end
