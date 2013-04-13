Animal::Application.routes.draw do
  match 'better/redirect' => 'better#redirect'
  match 'better/register' => 'better#register'
  resources :profile, :better
end
