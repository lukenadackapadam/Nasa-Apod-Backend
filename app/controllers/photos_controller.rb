class PhotosController < ApplicationController
  def index
    @photos = Photo.all()
    render :index
  end

  def create
    response = HTTP.get("https://api.nasa.gov/planetary/apod?api_key=#{ENV["NASA_API_KEY"]}")
    data = JSON.parse(response.body)

    photo = Photo.new(
      title: data["title"],
      explanation: data["explanation"],
      date: data["date"],
      hdurl: data["hdurl"],
    )
    if photo.save
      render json: { message: "Photo saved successfully", photo: photo }
    else
      render json: { error: "Failed to save photo", errors: photo.errors.full_messages }
    end
  end

  def show
    response = HTTP.get("https://api.nasa.gov/planetary/apod?api_key=#{ENV["NASA_API_KEY"]}")
    data = JSON.parse(response.body)
    title = data["title"]

    photo = Photo.find_by(title: title)
    
    if photo != nil
      render json: photo
    else
      create()
    end
  end
end
