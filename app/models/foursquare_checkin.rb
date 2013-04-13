class FoursquareCheckin < ActiveRecord::Base
  attr_accessible :category, :foursquare_user_id, :venue_id, :venue_name
end
