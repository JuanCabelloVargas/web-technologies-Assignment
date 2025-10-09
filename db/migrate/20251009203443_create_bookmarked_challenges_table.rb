class CreateBookmarkedChallengesTable < ActiveRecord::Migration[8.0]
  def change
    create_table :bookmarked_challenges do |t|
      t.references :user, null: false, foreign_key: true
      t.references :challenges, null: false, foreign_key: true
      t.timestamps
    end

    add_index :bookmarked_challenges, [ :user_id, :challenge_id ], unique: true
  end
end
