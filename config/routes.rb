Rails.application.routes.draw do
  post "/users" => "users#create"
  post "/sessions" => "sessions#create"
  get "/login" => "sessions#new"
  get "/logout" => "sessions#destroy"

  get "/apod_all" => "photos#index"
  get "/apod" => "photos#show"
  post "/apod" => "photos#create"
  
  get "/posts/:photo_id" => "posts#posts_by_photo"
  post "/post" => "posts#create"
  patch "/post" => "posts#update"
  delete "/post" => "posts#destroy"
end
