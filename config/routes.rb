Rails.application.routes.draw do
  get 'cards/show'
  resources :products
  resources :line_items
  resources :shops, only:[:index, :show]
  resources :order_items
  resource :cards, only:[:show]
  root "shops#index"
end
