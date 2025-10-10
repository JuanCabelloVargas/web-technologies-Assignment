class ChallengeCommentsController < ApplicationController
  before_action :set_challenge_comment, only: [ :show ]
  def index
    @challenge_comments = ChallengeComment.all
  end

  def show
  end

  private

  def set_challenge_comment
    @challenge_comment = ChallengeComment.find(params[:id])
  end
end
