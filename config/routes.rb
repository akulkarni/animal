Animal::Application.routes.draw do
  match 'better/redirect' => 'better#redirect'
  match 'better/register' => 'better#register'
  match 'better/receive_sms' => 'better#receive_sms'
  match 'better/foursquare_checkin' => 'better#foursquare_checkin'
  match 'better/workout_of_the_day' => 'better#workout_of_the_day'

  match 'record/send_nudge' => 'record#send_nudge_to_all_users'
  match 'record/send_ajay_nudge' => 'record#send_nudge_to_ajay'
  match 'record/receive_sms' => 'record#receive_sms'
  match 'record/:user_id/login' => 'record#login'
  match 'record/review' => 'record#review'
  match 'record/signup' => 'record#signup'
  match 'record/register' => 'record#register'

  match 'ping/new' => 'ping#new'

  resources :profile, :better, :record, :ping
end
