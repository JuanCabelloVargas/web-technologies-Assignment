class BookmarkedChallengesController < ApplicationController
  before_action :set_bookmarked_challenge, only: [:show]

  def index
    @bookmarked_challenges = BookmarkedChallenge.where(user: current_user)
  end

  def show
  end

  def toggle
    challenge_id = params[:challenge_id]
    bookmark = BookmarkedChallenge.find_by(user: current_user, challenge_id: challenge_id)

    if bookmark
      bookmark.destroy
      notice = "Challenge removed from bookmarks."
    else
      BookmarkedChallenge.create!(user: current_user, challenge_id: challenge_id)
      notice = "Challenge added to bookmarks."
    end

    redirect_to bookmarked_challenges_path, notice: notice
  end

  private

  def set_bookmarked_challenge
    @bookmarked_challenge = BookmarkedChallenge.find(params[:id])
  end
end
