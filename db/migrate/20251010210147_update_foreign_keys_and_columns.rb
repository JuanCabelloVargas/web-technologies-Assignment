class UpdateForeignKeysAndColumns < ActiveRecord::Migration[8.0]
  def change
    add_reference :challenges, :creator, null: false, foreign_key: { to_table: :users }
    add_reference :challenges, :category, null: false, foreign_key: true

    add_foreign_key :bookmarked_challenges, :challenges, column: :challenge_id

    add_index :challenge_comments, :challenge_id unless index_exists?(:challenge_comments, :challenge_id)
    add_foreign_key :challenge_comments, :challenges, column: :challenge_id

    add_foreign_key :challenge_requests, :challenges, column: :challenge_id

    add_foreign_key :user_badges, :badges,     column: :badge_id
    add_foreign_key :user_badges, :challenges, column: :challenge_id

    #rename_column :challenge_invites, :inviter_id_id,       :inviter_id
    #rename_column :challenge_invites, :inviter_user_id_id,  :invitee_user_id
  end
end
