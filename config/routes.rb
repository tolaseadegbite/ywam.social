Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    registrations: 'accounts/registrations'
  }
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'static_pages#home'
  
  resources :events do
    resources :event_talks
  end

  resources :accounts do
    resources :addresses
  end

  resources :rooms do
    resources :messages
  end

  get ':username', to: 'profiles#show', as: 'profile'
  put ':username/edit', to: 'profiles#update', as: 'edit_profile'
end
