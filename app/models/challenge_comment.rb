class ChallengeComment < ApplicationRecord
  belongs_to :challenge
  belongs_to :user

  after_create :notify_on_new_comment

  private

  def notify_on_new_comment
    if challenge.creator && challenge.creator != user
      NotificationService.create_notification(
        user: challenge.creator,
        notification_type: "comment",
        title: "Nuevo comentario en tu challenge",
        body: "#{user.username} comentó: #{body.truncate(140)}",
        related: self
      )
    end
  end
end
