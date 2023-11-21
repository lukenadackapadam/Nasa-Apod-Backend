Rails.application.routes.draw do
  post "/user" => "users#create"

  get "/apod" => "photos#show"
  post "/apod" => "photos#create"
  
  get "/posts" => "posts#index"
  post "/post" => "posts#create"
  patch "/post" => "posts#update"
  delete "/post" => "posts#destroy"
end
