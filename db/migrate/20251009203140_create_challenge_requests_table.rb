class CreateChallengeRequestsTable < ActiveRecord::Migration[8.0]
  def change
    rename_table :users_tabel, :users

    create_table :challenge_requests do |t|
      t.references :challenge, null: false, foreign_key: true
      t.references :requester, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false
      t.text :message
      t.references :decided_by, null: false, foreign_key: { to_table: :users }
      t.datetime :decided_at
      t.timestamps
    end
    add_index :challenge_requests, [ :challenge_id, :requester_id ], uniqueness: true
    add_index :challenge_requests, :status
  end
end
