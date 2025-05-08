Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'top' => 'homes#top', as: 'top'
  get "home/about" => "homes#about", as: "about"
  resources :books, only: [:new, :create ,:show, :index, :edit, :update, :destroy] do
   resources :post_comments,only: [:create,:edit,:update,:destroy]
  end
    resources :users, only: [:index, :show, :edit, :update]
end
