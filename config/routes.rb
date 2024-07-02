Rails.application.routes.draw do
  
  mount ActionCable.server, at: '/cable'

  resources :articles do
    resources :comments, only: %i[new create destroy], module: :articles
  end
  
  resources :rooms do
    resources :messages
    collection do
      post :search
    end
  end
  
  get 'rooms/leave/:id', to: 'rooms#leave', as: 'leave_room'
  get 'rooms/join/:id', to: 'rooms#join', as: 'join_room'
  
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations'
  }

  get "up" => "rails/health#show", as: :rails_health_check
  
  root to: 'static_pages#home'
  
  get 'account/:id', to: 'accounts#show', as: 'account'
  
  namespace :host do
    resources :events do
        
      resources :event_speakers, except: :index do
        resources :event_talks
      end
      
      member do
        post 'accept_co_host'
        post 'decline_co_host'
        post 'add_co_host'
        delete 'remove_co_host'
      end
    end
  end
  
  resources :events, only: [:index, :show] do
    member do
      post 'add_co_host'
      delete 'remove_co_host'
      post 'accept_co_host'
      post 'decline_co_host'
      post 'rsvp'
    end
  end
  
  resources :prayer_requests do
    resources :comments, only: %i[new create destroy], module: :prayer_requests
  end
  
  resources :accounts do
    resources :addresses
  end

  resources :comments, only: [] do
    resources :comments, only: %i[new create destroy], module: :comments
  end
  
  get ':username', to: 'profiles#show', as: 'profile'
  put ':username/edit', to: 'profiles#update', as: 'edit_profile'
end
