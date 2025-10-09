class CreateUsersTable < ActiveRecord::Migration[8.0]
  def change
    create_table :users_tables do |t|
      t.timestamps
    end
  end
end
