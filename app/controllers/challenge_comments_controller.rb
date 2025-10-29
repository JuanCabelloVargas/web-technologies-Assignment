class ChallengeCommentsController < ApplicationController
  before_action :set_challenge
  before_action :set_comment, only: [ :edit, :update, :destroy ]
  before_action :ensure_authenticated!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :ensure_comment_owner!, only: [ :edit, :update, :destroy ]

  def index
    @comments = @challenge.challenge_comments.visible.includes(:user).order(created_at: :desc)
  end

  def new
    @comment = @challenge.challenge_comments.new
  end

  def create
    @comment = @challenge.challenge_comments.new(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to challenge_path(@challenge, anchor: "comentarios"), notice: "Comment added."
    else
      redirect_to challenge_path(@challenge, anchor: "comentarios"), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to challenge_path(@challenge, anchor: "comentarios"), notice: "Comment updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to challenge_path(@challenge, anchor: "comentarios"), notice: "Comment removed."
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def set_comment
    @comment = @challenge.challenge_comments.find(params[:id])
  end

  def comment_params
    params.require(:challenge_comment).permit(:body)
  end

  def ensure_comment_owner!
    return if current_user && (@comment.user_id == current_user.id || @challenge.creator_id == current_user.id)
    redirect_to challenge_path(@challenge, anchor: "comentarios"), alert: "You are not allowed to modify this comment."
  end
end
