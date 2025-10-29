class ProgressLogsController < ApplicationController
  before_action :set_challenge
  before_action :ensure_authenticated!, except: [ :index ]
  before_action :ensure_participating!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_progress_log, only: [ :edit, :update, :destroy ]
  before_action :ensure_owner!, only: [ :edit, :update, :destroy ]

  def index
    @progress_logs = @challenge.progress_logs.includes(:user).recent
    @progress_log = @challenge.progress_logs.new(user: current_user, logged_at: Time.current)
    @can_log_progress = current_user.present? && participant_or_creator?
  end

  def new
    @progress_log = @challenge.progress_logs.new(user: current_user, logged_at: Time.current)
  end

  def create
    @progress_log = @challenge.progress_logs.new(progress_log_params.merge(user: current_user))

    if @progress_log.save
      redirect_to challenge_path(@challenge, anchor: "progreso"), notice: "Progress recorded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @progress_log.update(progress_log_params)
      redirect_to challenge_path(@challenge, anchor: "progreso"), notice: "Progress updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @progress_log.destroy
    redirect_to challenge_path(@challenge, anchor: "progreso"), notice: "Entry removed."
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def set_progress_log
    @progress_log = @challenge.progress_logs.find(params[:id])
  end

  def progress_log_params
    params.require(:progress_log).permit(:description, :progress_value, :unit, :logged_at)
  end

  def ensure_participating!
    return if current_user && participant_or_creator?
    redirect_to challenge_path(@challenge, anchor: "progreso"), alert: "You must join the challenge to log progress."
  end

  def ensure_owner!
    return if current_user && (@progress_log.user_id == current_user.id || @challenge.creator_id == current_user.id)
    redirect_to challenge_path(@challenge, anchor: "progreso"), alert: "You are not allowed to modify this entry."
  end

  def participant_or_creator?
    @challenge.creator_id == current_user.id ||
      @challenge.challenge_participations.exists?(user_id: current_user.id)
  end
end
