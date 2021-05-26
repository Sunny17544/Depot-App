Rails.application.routes.draw do
  get 'cards/show'
  resources :carts
  root "products#index"
  resources :line_items
  resources :products
  resources :order_items
  resource :cards, only:[:show]
end
