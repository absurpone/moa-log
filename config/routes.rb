Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts

  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
end
