Rails.application.routes.draw do
  resources :follows

  devise_for :users
  resources :users
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"

  resources :pictures do
    resources :comments, except: [:index]
    member do
      get :like
      get :unlike
    end
    # get '/unlike', to: 'pictures#unlike'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pictures#index"
end
