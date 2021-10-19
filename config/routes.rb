Rails.application.routes.draw do

  resources :sns
  root "home#top"

  get "users/:id/updateform" => "users#updateform"
  post "back/:id" => "users#back"
  post "users/:id/destroy" => "users#destroy"
  post "users/:id/update" => "users#update"
  post "logout" => "users#logout"
  post "users_signup" => "users#users_signup"
  get "/signup" => "users#signup"
  get "users/:id" => "users#show"

  post "tweet/:id/destroy" => "posts#tweet_destroy"
  post "tweet/:id" => "posts#tweet"
  get "posts/:id" => "posts#thread_show"

  post "login" => "home#login"
  post "thread_create" => "home#thread_create"
  get "/thread_creation" => "home#thread_creation"
  get '/' => "home#top"

end
