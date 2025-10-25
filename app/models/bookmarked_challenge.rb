class BookmarkedChallenge < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  validates :challenge_id, uniqueness: { scope: :user_id }

  after_create :notify_bookmark
  after_destroy :notify_unbookmark

  private

  def notify_bookmark
    NotificationService.create_notification(
      user: user,
      notification_type: "bookmark",
      title: "Challenge Bookmarked",
      body: "You bookmarked the challenge '#{challenge.name}'.",
      related: self
    )
  end

  def notify_unbookmark
    NotificationService.create_notification(
      user: user,
      notification_type: "bookmark",
      title: "Challenge Removed from Bookmarks",
      body: "You removed the challenge '#{challenge.name}' from your bookmarks.",
      related: self
    )
  end
end
