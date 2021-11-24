Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :profiles, only: [:index, :show, :new]
  resources :loans, only: [:new, :create, :show] do
    resources :loanees, only: [:new, :create]
    resources :weekly_payments, only: [:new, :create]
  end
end
