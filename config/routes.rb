Rails.application.routes.draw do
  root 'movies#index'
  resources :categories
  resources :movies do
    get 'search', on: :collection
  end
  get 'users/movies' => 'users#movies'
  post 'sign_in' => 'authentication#authenticate_user'
  post 'sign_up' => 'authentication#sign_up'
  post 'rating' => 'rating#create'
  resources :users, only: %i[show update]
end
