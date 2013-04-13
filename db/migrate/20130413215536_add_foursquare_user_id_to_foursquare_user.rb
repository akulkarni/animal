class AddFoursquareUserIdToFoursquareUser < ActiveRecord::Migration
  def change
    add_column :foursquare_users, :foursquare_user_id, :string
  end
end
