class ChangeChallengeInvitesNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :challenge_invites, :user_id, true
    change_column_null :challenge_invites, :accepted_at, true
  end
end
