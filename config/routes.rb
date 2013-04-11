Animal::Application.routes.draw do
  match 'better/redirect/:username' => 'better#redirect'

  resources :profile, :better
end
