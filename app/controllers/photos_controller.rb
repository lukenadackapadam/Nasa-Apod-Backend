class PhotosController < ApplicationController
  def show
    response = HTTP.get("https://api.nasa.gov/planetary/apod?api_key=#{ENV["NASA_API_KEY"]}")
    data = JSON.parse(response.body)
    render json: data
  end
end
