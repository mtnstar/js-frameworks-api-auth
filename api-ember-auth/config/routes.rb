Rails.application.routes.draw do

  resources :buddies

  get 'assets/index'
  root 'assets#index'

  # session management
  post 'sessions/create' => 'sessions#create'
  get 'sessions/destroy' => 'sessions#destroy'

end
