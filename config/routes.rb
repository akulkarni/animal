Animal::Application.routes.draw do
  match 'better/redirect/:username' => 'better#redirect'
  match 'better/auth/:username' => 'better#auth'

  resources :profile, :better
end
