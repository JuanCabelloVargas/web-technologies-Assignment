class ChallengeInvite < ApplicationRecord
  belongs_to :challenge
  belongs_to :inviter, class_name: "User"
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_user_id"

  validates :invitee_user_id, uniqueness: { scope: :challenge_id }

  after_update :notify_on_acceptance, if: :saved_change_to_is_accepted?

  private

  def notify_on_acceptance
    if is_accepted
      NotificationService.create_notification(
        user: inviter,
        notification_type: "invite",
        title: "Invitation Accepted",
        body: "#{invitee.username} accepted your invitation for '#{challenge.name}'.",
        related: self
      )
    else
      NotificationService.create_notification(
        user: inviter,
        notification_type: "invite",
        title: "Invitation Declined",
        body: "#{invitee.username} declined your invitation for '#{challenge.name}'.",
        related: self
      )
    end
  end
end
