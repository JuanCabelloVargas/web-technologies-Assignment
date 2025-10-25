class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge
  belongs_to :challenge, optional: true

  validates :user_id, uniqueness: true
  after_create :notify_award

  private

  def notify_award
    NotificationService.create_notification(
      user: user,
      notification_type: "badge_awarded",
      title: "You have received a badge",
      body: "You have obtained the badge #{badge.name}#{' in ' + challenge.name if challenge}",
      related: self
    )
  end
end
