Rails.application.routes.draw do
  resources :categories, only: [:index, :show]
  resources :challenges, only: [:index, :show] do
    resources :challenge_requests, only: [:create], path: "requests"
  end

  resources :challenge_requests, only: [:index, :show] do
    member do
      patch :approve
      patch :reject
    end
  end

  resources :challenge_invites do
    member do
      patch :accept
      patch :decline
    end
  end


  resources :bookmarked_challenges, only: [:index, :create, :destroy] do
    collection do
      post :toggle
    end
  end


  resources :notifications, only: [:index, :show] do
    member do
      patch :mark_as_read
    end
  end

  resources :challenge_participations, only: [:index, :show]
  resources :progress_logs, only: [:index, :show]
  resources :badges, only: [:index, :show]
  resources :users
  resources :user_badges
  resources :challenge_comments

  root "home#index"
end
