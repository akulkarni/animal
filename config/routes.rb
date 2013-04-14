Animal::Application.routes.draw do
  match 'better/redirect' => 'better#redirect'
  match 'better/register' => 'better#register'
  match 'better/receive_sms' => 'better#receive_sms'
  match 'better/foursquare_checkin' => 'better#foursquare_checkin'
  match 'better/workout_of_the_day' => 'better#workout_of_the_day'
  resources :profile, :better
end
