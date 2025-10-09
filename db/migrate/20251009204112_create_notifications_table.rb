class CreateNotificationsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.string :notification_type, null: false
      t.references :related, polymorphic: true, null: false
      t.boolean :is_read, null: false, default: false
      t.timestamps
    end

    add_index :notifications, [ :user_id, :is_read ]
    add_index :notifications, [ :related_type, :related_id ]
    add_index :notifications, :notification_type
  end
end
