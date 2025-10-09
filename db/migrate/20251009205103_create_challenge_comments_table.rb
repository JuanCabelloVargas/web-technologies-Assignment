class CreateChallengeCommentsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :challenge_comments do |t|
      t.bigint :challenge_id, null: false
      t.references :user, null: false, foreign_key: true
      t.text :body, null: false
      t.boolean :is_deleted, null: false, default: false
      t.datetime :edited_at
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
