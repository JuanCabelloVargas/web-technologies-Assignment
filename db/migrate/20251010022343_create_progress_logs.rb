class CreateProgressLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :progress_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true
      t.text :description
      t.float :progress_value, null: false
      t.string :unit, null: false
      t.datetime :logged_at, null: false
      
      t.timestamps
    end
  end
end
