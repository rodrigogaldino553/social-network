Rails.application.routes.draw do
  get 'likes/like'
  get 'likes/unlike'
  devise_for :users
  resources :pictures do
    resources :comments, except: [:index]
  end
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pictures#index"
end
