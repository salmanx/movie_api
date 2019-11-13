Rails.application.routes.draw do
  
  root "movies#index"
  resources :categories
  resources :movies
  post 'sign_in' => 'authentication#authenticate_user'
  post 'sign_up' => 'authentication#sign_up'
  # devise_for :users, controllers: { registrations: 'users' }
end

