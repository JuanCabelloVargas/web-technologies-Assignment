class MakeUserIdNullableInChallengeInvites < ActiveRecord::Migration[8.0]
  def change
    change_column_null :challenge_invites, :user_id, true
  end
end
