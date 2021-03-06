Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "/search" => "searches#search"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites,only:[:create,:destroy]
    resources :book_comments,only:[:create,:destroy]
  end
  
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships,only:[:create,:destroy]
    # あるユーザがフォローしているユーザを全てを取得
    get :followers, on: :member
    # あるユーザをフォローしているユーザを全てを取得
    get :followings, on: :member
  end
end