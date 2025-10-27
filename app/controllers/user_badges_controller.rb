class UserBadgesController < ApplicationController
  load_and_authorize_resource
  before_action :set_user_badge, only: [ :show ]

  def index
    @user_badges =
      if params[:user_id].present?
                     target = User.find(params[:user_id])
                     can?(:manage, :all) ? UserBadge.where(user_id: target.id) : UserBadge.where(user_id: current_user.id)
      else
                     UserBadge.where(user_id: current_user.id)
      end.order(created_at: :desc)
  end

  def show
  end

  def create
    @user_badge = UserBadge.new(user_badge_params)
    authorize! :create, @user_badge
    if @user_badge.save
      redirect_back fallback_location: user_badge_path(user_id: @user_badge.user_id),
        notice: "Badge created"
    else
      redirect_back fallback_location: user_badges_path(user_id: @user_badge.user_id),
        alert: @user_badge.errors.full_messages.to_sentence
    end
  end

  def destroy
    @user_badge = UserBadge.find(params[:id])
    authorize! :destroy, @user_badge
    user_id = @user_badge.user_id
    @user_badge.destroy

    redirect_back fallback_location: user_badges_path(user_id: user_id),
      notice: "Badge removed"
  end

  private

  def set_user_badge
    @user_badge = UserBadge.find(params[:id])
  end

  def user_badge_params
    params.require(:user_badge).permit(:user_id, :badge_id, :challenge_id, :awarded_at)
  end
end
