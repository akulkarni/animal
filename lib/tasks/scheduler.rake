task :update_workout_of_the_day => :environment do
  require 'open-uri'   
  puts "loading the WOD"
  open("http://animal-io.herokuapp.com/better/workout_of_the_day")
end