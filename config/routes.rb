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
  post 'orders/comfirm'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  resources :addresses
  resources :orders
  resources :items do
   resource :favorites, only: [:create, :destroy]
   resources :comments, only: [:create, :destroy]
  end
  resources :users

end
