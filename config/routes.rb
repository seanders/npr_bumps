NprBumps::Application.routes.draw do
  match 'auth/:provider/callback', to: 'sessions#create', via: :get
  root to: 'home#index'

  resources :auth, only: [:show]
  resources :person, only: [:show, :edit, :update]

  namespace :api do
    resources :playlists do
      collection do
        post 'sync'
      end

      member do
        get 'subscriptions'
        put 'subscriptions', to: "playlists#update_subscriptions"
      end
    end
  end

end
