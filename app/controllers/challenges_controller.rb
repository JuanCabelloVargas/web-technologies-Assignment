class ChallengesController < ApplicationController
  before action :set_challenge, only: [ :show ]
  def index
    @challenges = Challenge.all
  end

  def show
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end
end
