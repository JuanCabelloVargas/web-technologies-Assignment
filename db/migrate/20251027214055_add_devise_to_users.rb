class AddDeviseToUsers < ActiveRecord::Migration[8.0]
  def up
    remove_column :users, :password, :string if column_exists?(:users, :password)

    add_column :users, :email, :string, default: "", null: false unless column_exists?(:users, :email)
    add_column :users, :encrypted_password, :string, default: "",  null: false unless column_exists?(:users, :encrypted_password)
    add_column :users, :reset_password_token, :string unless column_exists?(:users, :reset_password_token)
    add_column :users, :reset_password_sent_at, :datetime unless column_exists?(:users, :reset_password_sent_at)
    add_column :users, :remember_created_at, :datetime unless column_exists?(:users, :remember_created_at)

    add_index :users, :email, unique: false unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
  end

  def down
    remove_index :users, :reset_password_token if index_exists?(:users, :reset_password_token)
    remove_index :users, :email if index_exists?(:users, :email)

    remove_column :users, :remember_created_at if column_exists?(:users, :remember_created_at)
    remove_column :users, :reset_password_sent_at if column_exists?(:users, :reset_password_sent_at)
    remove_column :users, :reset_password_token if column_exists?(:users, :reset_password_token)
    remove_column :users, :encrypted_password if column_exists?(:users, :encrypted_password)

    change_column_null :users, :email, true if column_exists?(:users, :email)
    change_column_default :users, :email, nil if column_exists?(:users, :email)

    add_column :users, :password, :string unless column_exists?(:users, :password)
  end
end
