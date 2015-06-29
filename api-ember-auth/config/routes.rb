Rails.application.routes.draw do

  resources :buddies, defaults: { format: :json }
  get 'assets/index'
  root 'assets#index'

  # session management
  post 'sessions/create' => 'sessions#create', defaults: { format: :json }
  get 'sessions/destroy' => 'sessions#destroy', defaults: { format: :json }

end
