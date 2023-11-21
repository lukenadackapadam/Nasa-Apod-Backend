class PhotosController < ApplicationController
  def create
    response = HTTP.get("https://api.nasa.gov/planetary/apod?api_key=#{ENV["NASA_API_KEY"]}")
    data = JSON.parse(response.body)
    
    @photo = Photo.new(
      title: data["title"],
      explanation: data["explanation"],
      date: data["date"],
      hdurl: data["hdurl"],
    )
    if @photo.save
      render json: { message: "Photo saved successfully", photo: @photo }
    else
      render json: { error: "Failed to save photo", errors: @photo.errors.full_messages }
    end
  end

  def show
    # Create a DateTime object in user's local timezone
    local_date = DateTime.now

    utc_date = local_date.in_time_zone("UTC").beginning_of_day
        
    @photo = Photo.find_by(date: utc_date)

    if @photo && @photo.date == utc_date
      render :show
    else
      create()
    end
  end
end
