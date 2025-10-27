class HardenUsersFOrDeviseAndRoles < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :role_tmp, :integer, default: 0, null: false

    remove_column :users, :role
    rename_column :users, :role_tmp, :role
    add_index :users, :role unless index_exists?(:users, :role)
  end

  def down
    remove_index :users, :role if index_exists?(:users, :role)
    add_column :users, :role, :string

    remove_column :users, :role_tmp
  end
end
