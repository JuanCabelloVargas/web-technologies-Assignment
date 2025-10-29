class ChallengeRequestsController < ApplicationController
  before_action :ensure_authenticated!
  before_action :set_challenge_request, only: [ :show, :approve, :reject ]
  before_action :ensure_can_manage_request!, only: [ :approve, :reject ]

  def index
    @incoming_requests = ChallengeRequest
                           .includes(:challenge, :requester)
                           .joins(:challenge)
                           .where(challenges: { creator_id: current_user.id })

    @outgoing_requests = ChallengeRequest
                           .includes(:challenge)
                           .where(requester: current_user)
  end

  def show
  end

  def create
    attributes = challenge_request_params.merge(
      challenge_id: params[:challenge_id],
      requester_id: current_user.id,
      status: "pending"
    )

    @challenge_request = ChallengeRequest.new(attributes)

    if @challenge_request.save
      redirect_to challenge_requests_path, notice: "Request created successfully."
    else
      redirect_back fallback_location: challenge_path(params[:challenge_id]), alert: "Failed to create request."
    end
  end

  def approve
    if @challenge_request.update(status: "approved", decided_by: current_user)
      redirect_to challenge_requests_path, notice: "Request approved."
    else
      redirect_back fallback_location: challenge_requests_path, alert: "Failed to approve request."
    end
  end

  def reject
    if @challenge_request.update(status: "rejected", decided_by: current_user)
      redirect_to challenge_requests_path, notice: "Request rejected."
    else
      redirect_back fallback_location: challenge_requests_path, alert: "Failed to reject request."
    end
  end

  private

  def set_challenge_request
    @challenge_request = ChallengeRequest.find(params[:id])
  end

  def ensure_can_manage_request!
    return if current_user.admin? || @challenge_request.challenge.creator_id == current_user.id
    redirect_to challenge_requests_path, alert: "You are not allowed to manage this request."
  end

  def challenge_request_params
    params.fetch(:challenge_request, {}).permit(:message)
  end
end
