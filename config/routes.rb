Rails.application.routes.draw do
  get "/apod" => "photos#show"

  post "/user" => "users#create"
end
