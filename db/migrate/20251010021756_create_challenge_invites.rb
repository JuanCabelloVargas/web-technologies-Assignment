class CreateChallengeInvites < ActiveRecord::Migration[8.0]
  def change
    create_table :challenge_invites do |t|
      t.references :challenge, null: false, foreign_key: true
      t.belongs_to :inviter_id, null: false, foreign_key: {to_table: :users}
      t.belongs_to :inviter_user_id, null: false, foreign_key: {to_table: :users}

      t.datetime :accepted_at, null: false
      t.boolean :is_accepted, null: false
      
      t.timestamps
    end
  end
end
