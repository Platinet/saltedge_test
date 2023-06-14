Rails.application.routes.draw do
  default_url_options host: "localhost:3000"
  devise_for :users, controllers: {registrations: "registrations"}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  resources :home, only: :index
  resources :customers, only: :create
  resources :connect_sessions, only: :create
  resources :connections, only: [:index, :destroy] do
    put "refresh", on: :member
    put "reconnect", on: :member
    resources :accounts, only: :index do
      resources :transactions, only: :index
    end
  end

  namespace :admin do
    resources :connections, only: [:index, :show]
    resources :accounts, only: [:index, :show]
    resources :transactions, only: [:index, :show]
  end
  end
end
