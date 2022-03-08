Rails.application.routes.draw do
  devise_for :users
  get 'rooms/show'
  get 'addresses/index'
  get 'addresses/edit'
  get 'orders/new'
  get 'orders/thanks'
  get 'orders/index'
  get 'orders/show'
  get 'items/index'
  get 'items/new'
  get 'items/show'
  get 'items/comfirm'
  get 'items/complete'
  get 'users/show'
  get 'users/mypage'
  get 'users/edit'
  get 'users/unscribe'
  get 'homes/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
