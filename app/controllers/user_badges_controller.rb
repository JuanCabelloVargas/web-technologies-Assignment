class UserBadgesController < ApplicationController
  before_action :set_user_badge, only: [ :show ]

  def index
    @user_badges = UserBadge.all
  end

  def show
  end

  private

  def set_user_badge
    @user_badge = UserBadge.find(params[:id])
  end
end
