class ChallengeParticipationsController < ApplicationController
  before_action :set_challenge_participation, only: [ :show ]

  def index
    @participations = ChallengeParticipation.all
  end

  def show
  end

  private

  def set_challenge_participation
    @participation = ChallengeParticipation.find(params[:id])
  end
end
