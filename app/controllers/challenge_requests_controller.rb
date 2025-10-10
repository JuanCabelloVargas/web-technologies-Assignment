class ChallengeRequestsController < ApplicationController
  before action :set_challenge_request, only: [ :show ]

  def index
    @challenge_requests = ChallengeRquest.all
  end

  def show
  end

  private

  def set_challenge_request
    @challenge_request = ChallengeRequest.find(params[:id])
  end
end
