class ChallengeInvitesController < ApplicationController
  def index
    @invites = ChallengeInvite.all
  end

  def show
    @invite = ChallengeInvite.find(params[:id])
  end
end
