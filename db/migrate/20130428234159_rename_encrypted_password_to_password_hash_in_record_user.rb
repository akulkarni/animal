class RenameEncryptedPasswordToPasswordHashInRecordUser < ActiveRecord::Migration
  def change
    rename_column :record_users, :encrypted_password, :password_hash
  end
end
