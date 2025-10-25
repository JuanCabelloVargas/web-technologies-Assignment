class NotificationService
  def self.create_notification(user:, notification_type:, title:, body:, related: nil)
    return unless user.present?

    Notification.create!(
      user: user,
      notification_type: notification_type,
      title: title,
      body: body,
      related: related
    )
  end
end
