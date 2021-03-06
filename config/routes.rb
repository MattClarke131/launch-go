Rails.application.routes.draw do
  root "challenges#index"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :challenges, only: [:index]
  resources :games, only: [:show]

  namespace :api do
    namespace :v1 do
      resources :challenges, only: [:index, :create, :destroy, :show]
      resources :games, only: [:show, :create, :update]
    end
  end
end
