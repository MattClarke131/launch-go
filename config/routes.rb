Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :challenges, only: [:index]
  resources :games, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :challenges, only: [:index]
      resources :games, only: [:show]
    end
  end
end
