Rails.application.routes.draw do

  resources :buddies, defaults: { format: :json }
  get 'assets/index'
  root 'assets#index'

  # session management
  post 'session/create' => 'sessions#create', defaults: { format: :json }
  get 'session/destroy' => 'sessions#destroy', defaults: { format: :json }

end
