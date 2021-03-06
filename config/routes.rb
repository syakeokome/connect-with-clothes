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
  #get 'user/:user_id/orders', to: 'orders#index', as: 'user_orders'
 # get "orders/show/:id", to: "orders#show", as: "orders_show"
 # get "orders/index"
  #get 'user/:user_id/orders', to: 'orders#show', as: 'user_order'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :messages, only: [:create]
  resources :orders, only: [:index, :show]
  resources :rooms, only: [:create, :show, :index]
  resources :addresses
  resources :items do
   post 'orders/comfirm'
   get 'orders/thanks'
   resources :orders,  except: [:index, :show]
   resource :favorites, only: [:create, :destroy]
   resources :comments, only: [:create, :destroy]
  end
  resources :users

end
