class CreateUserBadgesTable < ActiveRecord::Migration[8.0]
  def change
    create_table :user_badges do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :badge_id, null: false
      t.bigint :challenge_id, null: false
      t.datetime :awarded_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.timestamps
    end
    add_index :user_badges, [ :user_id, :badge_id, :challenge_id ], unique: true
    add_index :user_badges, :badge_id
    add_index :user_badges, :challenge_id
  end
end
