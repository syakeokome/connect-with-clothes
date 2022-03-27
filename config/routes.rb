Rails.application.routes.draw do

  root to: 'items#index'
  devise_for :users
  post 'items/comfirm'
  get 'items/complete'
  get 'items/exhibit'
  get 'users/mypage'
  get 'users/unscribe'
  get 'homes/about'
  get 'items/individual'
  patch 'users/withdraw'
  get "search" => "searches#search"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  resources :addresses
  resources :items do
   post 'orders/comfirm'
   get 'orders/thanks'
   resources :orders
   resource :favorites, only: [:create, :destroy]
   resources :comments, only: [:create, :destroy]
  end
  resources :users

end
