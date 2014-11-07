NprBumps::Application.routes.draw do
  match 'auth/:provider/callback', to: 'sessions#create', via: :get
  root to: 'home#index'

  resources :auth, only: [:show]
  resources :person, only: [:show, :edit, :update]
  post 'playlist/sync', to: 'playlist#sync'
end
