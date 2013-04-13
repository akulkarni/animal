class AddPhoneNumberToFoursquareUsers < ActiveRecord::Migration
  def change
    add_column :foursquare_users, :phone_number, :string
  end
end
