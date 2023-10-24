Rails.application.routes.draw do
  get "/apod" => "photos#show"

  post "/post" => "posts#create"

  post "/user" => "users#create"
end
