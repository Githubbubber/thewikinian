Rails.application.routes.draw do
  root to: "welcome#index"
  get "othergems", to: "welcome#othergems"
  resources :welcome, only: [:index, :othergems]
  resources :posts, only: [:index, :show, :create]
end
