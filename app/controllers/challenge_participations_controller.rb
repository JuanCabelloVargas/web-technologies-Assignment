class ChallengeParticipationsController < ApplicationController
  def index
    @participations = ChallengeParticipation.all
  end

  def show
    @participation = ChallengeParticipation.find(params[:id])
  end
end
