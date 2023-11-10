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

  def datetime
    # Create a DateTime object in user's local timezone
    local_date = DateTime.now
    puts "+++"
    puts local_date
    
    # Convert the local DateTime to UTC timezone
    utc_date = local_date.new_offset(0)
    puts "+++"
    puts utc_date

    # Set the converted UTC DateTime to midnight (00:00:00)
    utc_date = DateTime.new(utc_date.year, utc_date.month, utc_date.day, 0, 0, 0, 0)
    puts "+++"
    p utc_date
  end
end
