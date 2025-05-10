Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'top' => 'homes#top', as: 'top'
  get "home/about" => "homes#about", as: "about"
  resources :books, only: [:new, :create ,:show, :index, :edit, :update, :destroy] do
   resources :book_comments,only: [:create,:destroy]
   resource :favorite, only: [:create, :destroy]
  end
    resources :users, only: [:index, :show, :edit, :update]
end
