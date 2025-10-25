class ChallengeRequestsController < ApplicationController
  before_action :set_challenge_request, only: [:show, :approve, :reject]

  def index
    # Muestra todas las requests del usuario actual
    @challenge_requests = ChallengeRequest.where(requester: current_user)
  end

  def show
  end

  def create
    @challenge_request = ChallengeRequest.new(
      challenge_id: params[:challenge_id],
      requester_id: current_user.id,
      status: "pending"
    )

    if @challenge_request.save
      redirect_to challenge_requests_path, notice: "Request created successfully."
    else
      redirect_back fallback_location: challenge_path(params[:challenge_id]), alert: "Failed to create request."
    end
  end

  def approve
    if @challenge_request.update(status: "approved", decided_by_id: current_user.id)
      redirect_to challenge_requests_path, notice: "Request approved."
    else
      redirect_back fallback_location: challenge_requests_path, alert: "Failed to approve request."
    end
  end

  def reject
    if @challenge_request.update(status: "rejected", decided_by_id: current_user.id)
      redirect_to challenge_requests_path, notice: "Request rejected."
    else
      redirect_back fallback_location: challenge_requests_path, alert: "Failed to reject request."
    end
  end

  private

  def set_challenge_request
    @challenge_request = ChallengeRequest.find(params[:id])
  end
end
