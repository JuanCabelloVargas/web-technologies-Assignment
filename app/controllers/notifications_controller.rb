class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :mark_as_read]

  def index
    @notifications = Notification.all
  end

  def show
  end

  def mark_as_read
    @notification.update(is_read: true)
    redirect_to notifications_path, notice: "Notification marked as read."
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
