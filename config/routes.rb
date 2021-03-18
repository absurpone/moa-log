Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts do
    collection do
      get 'search'
    end
  end
  resources :users, only: :show

  get 'favorites/index'
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
end
