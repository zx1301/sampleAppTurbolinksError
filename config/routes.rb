Rails.application.routes.draw do
  resources :movies
  resources :posts
  #root to: 'posts#index'
  root to: 'pages#index'

  get :search, controller: :main
  #devise_for :users
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
