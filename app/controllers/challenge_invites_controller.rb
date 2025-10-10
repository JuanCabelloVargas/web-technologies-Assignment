class ChallengeInvitesController < ApplicationController
  before_action :set_challenge_invite, only: [ :show ]
  def index
    @invites = ChallengeInvite.all
  end

  def show
  end

  private

  def set_challenge_invite
    @invite = ChallengeInvite.find(params[:id])
  end
end
