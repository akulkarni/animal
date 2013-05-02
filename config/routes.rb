Animal::Application.routes.draw do
  match 'better/redirect' => 'better#redirect'
  match 'better/register' => 'better#register'
  match 'better/receive_sms' => 'better#receive_sms'
  match 'better/foursquare_checkin' => 'better#foursquare_checkin'
  match 'better/workout_of_the_day' => 'better#workout_of_the_day'

  match 'record/send_nudge' => 'record#send_nudge_to_all_users'
  match 'record/receive_sms' => 'record#receive_sms'
  match 'record/login' => 'record#login'
  match 'record/signup' => 'record#signup'
  match 'record/register' => 'record#register'
  resources :profile, :better, :record
end
