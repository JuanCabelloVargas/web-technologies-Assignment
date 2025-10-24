Rails.application.routes.draw do
  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  resources :categories, only: [ :index, :show ]
  resources :challenges, only: [ :index, :show ]
  resources :challenge_participations, only: [ :index, :show ]
  resources :challenge_invites, only: [ :index, :show ]
  resources :progress_logs, only: [ :index, :show ]
  resources :badges, only: [ :index, :show ]
  resources :users
  resources :challenge_requests
  resources :bookmarked_challenges
  resources :notifications
  resources :user_badges
  resources :challenge_comments
  root "home#index"
end
