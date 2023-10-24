Rails.application.routes.draw do
  get "/apod" => "photos#show"

  post "/post" => "posts#create"
  patch "/post" => "posts#update"
  delete "/post" => "posts#destroy"

  post "/user" => "users#create"
end
