Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [ :index, :show ]

  resources :categories, only: [ :index, :show ]

  resources :challenges do
    resources :challenge_requests, only: [ :create ], path: "requests"
    resources :challenge_participations, only: [ :index, :create, :destroy ]
    resources :challenge_comments, except: [ :show ]
    resources :progress_logs, except: [ :show ]
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

  resources :badges,                   only: [ :index, :show ]

  resources :user_badges,        only: [ :index, :show, :create, :destroy ]

  root "home#index"
end
