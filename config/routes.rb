Rails.application.routes.draw do
  post "/sessions" => "sessions#create"
  post "/user" => "users#create"

  get "/apod_all" => "photos#index"
  get "/apod" => "photos#show"
  post "/apod" => "photos#create"
  
  get "/posts/:photo_id" => "posts#posts_by_photo"
  post "/post" => "posts#create"
  patch "/post" => "posts#update"
  delete "/post" => "posts#destroy"
end
