Rails.application.routes.draw do
  # devise_for :users
  devise_for :users
  root to: 'pages#home'
  resources :profiles, only: [:index, :show, :new]
  resources :loans, only: [:new, :create, :show] do
    resources :loanees, only: [:new, :create]
    resources :weekly_payments, only: [:new, :create]
  end
  resources :users, only: [:new ]
  post 'user_profile', to: "users#create", as: 'user_profile'
end
