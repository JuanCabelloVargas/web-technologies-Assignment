class ChallengeParticipationsController < ApplicationController
  before_action :set_challenge
  before_action :set_participation, only: [ :destroy ]
  before_action :ensure_authenticated!, only: [ :create, :destroy ]

  def index
    @participations = @challenge.challenge_participations.includes(:user).order(created_at: :desc)
  end

  def create
    @participation = @challenge.challenge_participations.find_or_initialize_by(user: current_user)
    @participation.status ||= "active"

    if @participation.persisted?
      redirect_to challenge_path(@challenge, anchor: "participantes"), alert: "You already joined this challenge."
    elsif @participation.save
      redirect_to challenge_path(@challenge, anchor: "participantes"), notice: "You joined the challenge."
    else
      redirect_to challenge_path(@challenge, anchor: "participantes"), alert: @participation.errors.full_messages.to_sentence
    end
  end

  def destroy
    unless can_manage_participation?(@participation)
      redirect_to challenge_path(@challenge, anchor: "participantes"), alert: "You are not allowed to remove this participation."
      return
    end

    @participation.destroy
    redirect_to challenge_path(@challenge, anchor: "participantes"), notice: "Participation removed."
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def set_participation
    @participation = @challenge.challenge_participations.find(params[:id])
  end

  def can_manage_participation?(participation)
    return false unless current_user
    participation.user_id == current_user.id || @challenge.creator_id == current_user.id
  end

end
