class FoursquareUser < ActiveRecord::Base
  attr_accessible :access_token, :name, :username, :phone_number
end
