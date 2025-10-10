class BookmarkedChallengesController < ApplicationController
  before_action :set_bookmarked_challenge, only: [ :show ]

  def index
    @bookmarked_challenges = BookmarkedChallenge.all
  end

  def show
  end

  private

  def set_bookmarked_challenge
    @bookmarked_challenge = BookmarkedChallenge.find(params[:id])
  end
end
