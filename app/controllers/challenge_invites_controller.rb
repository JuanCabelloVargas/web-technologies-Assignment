class ChallengeInvitesController < ApplicationController
  before_action :set_challenge_invite, only: [:show, :accept, :decline]

  def index
    @invites = ChallengeInvite.all
  end

  def show
  end

  def accept
    @invite = ChallengeInvite.find(params[:id])
    @invite.update(is_accepted: true, accepted_at: Time.current)
    redirect_to challenge_invites_path, notice: "Invite accepted successfully."
  end

  def decline
    @invite = ChallengeInvite.find(params[:id])
    @invite.update(is_accepted: false, accepted_at: Time.current)
    redirect_to challenge_invites_path, alert: "Invite declined."
  end

  private

  def set_challenge_invite
    @invite = ChallengeInvite.find(params[:id])
  end
end
