class CreateFoursquareCheckins < ActiveRecord::Migration
  def change
    create_table :foursquare_checkins do |t|
      t.string :foursquare_user_id
      t.string :venue_id
      t.string :venue_name
      t.string :category

      t.timestamps
    end
  end
end
