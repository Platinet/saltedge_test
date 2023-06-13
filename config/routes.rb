Rails.application.routes.draw do
  default_url_options host: "localhost:3000"
  devise_for :users, controllers: {registrations: "registrations"}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  resources :home, only: :index
  resources :customers, only: :create
end
