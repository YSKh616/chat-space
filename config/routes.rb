Rails.application.routes.draw do
  devise_for :users
  root  'messages#index'
  get 'messages' => 'messages#index'
  resources :users, only: [:edit, :update]
  resources :groups, only: [:edit, :update, :new, :create, :index]
end
