Rails.application.routes.draw do
  resources :follows

  #devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, param: :permalink
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  get '/users/:id/followers', to: "users#followers", as: "user_followers"
  get '/users/:id/followees', to: "users#followees", as: "user_followees"

  resources :pictures do
    resources :comments, except: [:index]
    member do
      get :like
      get :unlike
      patch :approve
    end
    # get '/unlike', to: 'pictures#unlike'
  end

  get '/privacy_policy', to: "pictures#privacy_policy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pictures#index"
end
