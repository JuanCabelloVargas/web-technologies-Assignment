class ChallengesController < ApplicationController
  before_action :ensure_authenticated!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :ensure_creator_role!, only: [ :new, :create ]
  before_action :set_challenge, only: [ :show, :edit, :update, :destroy ]
  before_action :ensure_creator!, only: [ :edit, :update, :destroy ]
  before_action :load_form_collections, only: [ :new, :create, :edit, :update ]

  def index
    load_form_collections
    @filters = {
      category_id: params[:category_id],
      visibility: params[:visibility],
      status: params[:status]
    }

    @challenges = Challenge.includes(:category, :creator)
                           .by_category(@filters[:category_id])
                           .by_visibility(@filters[:visibility])
                           .by_status(@filters[:status])
                           .order(start_date: :asc)
  end

  def show
    @participations = @challenge.challenge_participations.includes(:user)
    @progress_logs   = @challenge.progress_logs.includes(:user).recent
    @comments        = @challenge.challenge_comments.visible.includes(:user).order(created_at: :desc)
    @participation   = @challenge.challenge_participations.find_by(user: current_user) if current_user
    @comment         = @challenge.challenge_comments.new
    @progress_log    = @challenge.progress_logs.new(logged_at: Time.current)
    @can_log_progress = current_user.present? && (
      @challenge.creator_id == current_user.id ||
      @challenge.challenge_participations.exists?(user_id: current_user.id)
    )
    if current_user
      @challenge_request = current_user.requests_made.find_by(challenge: @challenge)
      @user_requests = current_user.requests_made.where(challenge: @challenge).order(created_at: :desc)
    else
      @user_requests = []
    end
  end

  def new
    @challenge = Challenge.new(
      start_date: Time.current.beginning_of_day,
      end_date: Time.current.end_of_day + 7.days,
      visibility: Challenge::VISIBILITIES.first,
      status: Challenge::STATUSES.first
    )
  end

  def create
    @challenge = Challenge.new(challenge_params.merge(creator: current_user))

    if @challenge.save
      redirect_to @challenge, notice: "Challenge created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @challenge.update(challenge_params)
      redirect_to @challenge, notice: "Challenge updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @challenge.destroy
    redirect_to challenges_path, notice: "Challenge deleted."
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def ensure_creator!
    return if current_user && @challenge.creator_id == current_user.id
    redirect_to challenge_path(@challenge), alert: "Only the creator can perform this action."
  end

  def ensure_creator_role!
    return if current_user&.creator? || current_user&.admin?
    redirect_to challenges_path, alert: "You must be a creator to create challenges."
  end

  def challenge_params
    params.require(:challenge).permit(
      :name,
      :description,
      :start_date,
      :end_date,
      :visibility,
      :status,
      :category_id
    )
  end

  def load_form_collections
    @categories   = Category.order(:name)
    @visibilities = Challenge::VISIBILITIES
    @statuses     = Challenge::STATUSES
  end
end
