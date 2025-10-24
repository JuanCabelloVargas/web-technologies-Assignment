class AddInviterColumnsToChallengeInvites < ActiveRecord::Migration[8.0]
  def change
    add_reference :challenge_invites, :inviter, foreign_key: { to_table: :users }, null: false
    add_reference :challenge_invites, :invitee_user, foreign_key: { to_table: :users }, null: false
  end
end
