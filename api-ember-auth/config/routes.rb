Rails.application.routes.draw do

  resources :buddies, defaults: { format: :json }
  get 'assets/index'
  root 'assets#index'

  # session management
  get 'session/create' => 'sessions#create'
  get 'session/destroy' => 'sessions#destroy'

end
