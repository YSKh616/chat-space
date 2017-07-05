Rails.application.routes.draw do
  devise_for :users
  root  'groups#index'
  resources :users, only: [:edit, :update]
  resources :groups, only: [:edit, :update, :new, :create, :index] do
    resources :messages, only: [:index, :new, :create]
  end
end
