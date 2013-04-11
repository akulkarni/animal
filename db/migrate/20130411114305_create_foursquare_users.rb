class CreateFoursquareUsers < ActiveRecord::Migration
  def change
    create_table :foursquare_users do |t|
      t.string :username
      t.string :name
      t.string :access_token

      t.timestamps
    end
  end
end
