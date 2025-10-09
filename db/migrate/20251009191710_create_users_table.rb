class CreateUsersTable < ActiveRecord::Migration[8.0]
  def change
    create_table :users_tables do |t|
      t.string :username, null: false
      t.string :role, null: false, default: "member"
      t.string :email, null: false
      t.string :password, null: false
      t.text :avatar_url

      t.timestamps
    end
  end
end
