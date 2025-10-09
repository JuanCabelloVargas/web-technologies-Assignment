class CreateUsersTable < ActiveRecord::Migration[8.0]
  def change
    create_table :users_tables do |t|
      t.string :username
      t.string :role
      t.string :email
      t.string :password
      t.text :avatar_url

      t.timestamps
    end
  end
end
