Rails.application.routes.draw do

  root to: 'items#index'
  devise_for :users
  get 'orders/thanks'
  post 'items/comfirm'
  get 'items/complete'
  get 'users/mypage'
  get 'users/unscribe'
  get 'homes/about'
  get 'items/individual'
  patch 'users/withdraw'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :rooms
  resources :addresses
  resources :orders
  resources :items
  resources :users
end
