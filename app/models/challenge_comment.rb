class ChallengeComment < ApplicationRecord
  belongs_to :challenge
  belongs_to :user

  before_update :mark_as_edited, if: :will_save_change_to_body?

  validates :body, presence: true

  scope :visible, -> { where(deleted_at: nil, is_deleted: false) }

  after_create :notify_on_new_comment

  def destroy
    run_callbacks(:destroy) { soft_delete }
  end

  private

  def notify_on_new_comment
    return unless challenge.creator && challenge.creator != user
    NotificationService.create_notification(
      user: challenge.creator,
      notification_type: "comment",
      title: "New comment in your challenge",
      body: "#{user.username} comented: #{body.truncate(140)}",
      related: self
    )
  end

  def mark_as_edited
    self.edited_at = Time.current
  end

  def soft_delete
    update_columns(is_deleted: true, deleted_at: Time.current)
  end
end
