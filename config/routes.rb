Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'static_pages#home'
  
  resources :events do
    resources :event_talks
  end
end
