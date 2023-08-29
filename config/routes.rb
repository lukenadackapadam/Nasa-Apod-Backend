Rails.application.routes.draw do
  get "/apod" => "photos#show"
end
