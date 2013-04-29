class AddHashedPasswordAndSaltToRecordUser < ActiveRecord::Migration
  def change
    remove_column :record_users, :password
    add_column :record_users, :encrypted_password, :string
    add_column :record_users, :password_salt, :string
  end
end
