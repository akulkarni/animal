Animal::Application.routes.draw do
  match 'better/redirect' => 'better#redirect'
  resources :profile, :better
end
