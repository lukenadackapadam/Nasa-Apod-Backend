class PhotosController < ApplicationController
  before_action :authenticate_user

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
      # render json: { message: "Photo saved successfully", photo: photo }
      render json: photo
    else
      render json: photo.errors.full_messages 
    end
  end

  def show
    response = HTTP.get("https://api.nasa.gov/planetary/apod?api_key=#{ENV["NASA_API_KEY"]}")
    data = JSON.parse(response.body)
    title = data["title"]

    headers = response.headers
    
    puts "X-RATELIMIT-LIMIT"
    puts headers['x-ratelimit-limit']

    puts "X-RATELIMIT-REMAINING"
    puts headers['x-ratelimit-remaining']

    photo = Photo.find_by(title: title)
    
    if photo != nil
      render json: photo
    else
      create()
    end
  end
end
