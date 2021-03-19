Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts do
    collection do
      get 'search'
      get 'search_hokkaido_tohoku'
      get 'search_kanto'
      get 'search_chubu'
      get 'search_kinki'
      get 'search_chugoku_shikoku'
      get 'search_kyusyu_okinawa'
    end
  end
  resources :users, only: :show

  get 'favorites/index'
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
end
