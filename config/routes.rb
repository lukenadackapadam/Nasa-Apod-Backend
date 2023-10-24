Rails.application.routes.draw do
  get "/apod" => "photos#show"

  post "/post" => "posts#create"
  patch "/post" => "posts#update"

  post "/user" => "users#create"
end
