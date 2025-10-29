class AddUniqueIndexToChallengeParticipations < ActiveRecord::Migration[8.0]
  def change
    add_index :challenge_participations,
              [ :challenge_id, :user_id ],
              unique: true,
              name: "index_challenge_participations_on_challenge_and_user"
  end
end
