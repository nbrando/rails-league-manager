Rails.application.routes.draw do
  get "team_seasons/show"
  get "team_seasons/index"
  get "teams/show"
  get "teams/index"
  get "leagues/show"
  get "leagues/index"


  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
   root "home#index"

   get "/login", to: "sessions#new"
   post "/login", to: "sessions#create"
   delete "/logout", to: "sessions#destroy"

   get "/signup", to: "users#new", as: :signup

  resources :leagues do
    member do
      get :fixtures
      get :ladder
    end
  end

  resources :team_seasons do
    member do
      get :fixtures
      get :ladder
    end
  end

  resources :sports
  resources :divisions
  resources :organisations
  resources :teams
  resources :seasons
  resources :rounds
  resources :venues
  resources :matches
  resources :match_results
  resources :users
  resources :players
  resources :player_registrations
  resources :user_roles
end
