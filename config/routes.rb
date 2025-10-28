Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [ :index, :show ]

  resources :categories, only: [ :index, :show ]

  resources :challenges, only: [ :index, :show ] do
    resources :challenge_requests, only: [ :create ], path: "requests"
  end

  resources :challenge_requests, only: [ :index, :show ] do
    member do
      patch :approve
      patch :reject
    end
  end

  resources :challenge_invites, only: [ :index, :show, :create, :update, :destroy ] do
    member do
      patch :accept
      patch :decline
    end
  end

  resources :bookmarked_challenges, only: [ :index, :create, :destroy ] do
    collection do
      post :toggle
    end
  end

  resources :notifications, only: [ :index, :show ] do
    member do
      patch :mark_as_read
    end
  end

  resources :challenge_participations, only: [ :index, :show ]
  resources :progress_logs,            only: [ :index, :show ]
  resources :badges,                   only: [ :index, :show ]

  resources :user_badges,        only: [ :index, :show, :create, :destroy ]
  resources :challenge_comments, only: [ :index, :show, :create, :update, :destroy ]

  root "home#index"
end
