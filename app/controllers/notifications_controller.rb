class NotificationsController < ApplicationController
  before_action :set_notification, only: [ :show ]

  def index
    @notifications = Notification.all
  end

  def show
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
