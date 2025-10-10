class UserBadgesControler < ApplicationControler
  before_action :set_user_badge, only: [ :show ]

  def index
    @user_badges = UserBadges.all
  end

  def show
  end

  private
  def set_user_badge
    @user_badge = UserBadge.find(params[:id])
  end
end
