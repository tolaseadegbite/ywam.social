Rails.application.routes.draw do

  mount ActionCable.server, at: '/cable'

  resources :rooms do
    resources :messages
  end
  
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations'
  }
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'static_pages#home'

  get 'account/:id', to: 'accounts#show', as: 'account'
  
  resources :events do
    resources :event_talks
  end

  resources :accounts do
    resources :addresses
  end

  get ':username', to: 'profiles#show', as: 'profile'
  put ':username/edit', to: 'profiles#update', as: 'edit_profile'
end
