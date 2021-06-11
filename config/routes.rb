Rails.application.routes.draw do

  devise_for :users
  root 'movies#index'
  get 'movies/search'
  get 'movies/show'
  get '/movies', to: "movies#index", as: :post_keyward

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  get 'users/:id/follower'=> 'users#follower', as: 'follower_user'
  get 'users/:id/followed'=> 'users#followed', as: 'followed_user'

  resources :users, only: [:index, :show, :edit, :update]

  resources :reviews, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
  end

  resources :reviews do
    resource :good, only: [:create, :destroy]
    resource :bad, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
