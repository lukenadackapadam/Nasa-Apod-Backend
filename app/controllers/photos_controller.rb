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

  def convertUserDateTimeToUtc
    # Create a DateTime object in user's local timezone
    local_date = DateTime.now
    
    # Convert the local DateTime to UTC timezone
    utc_date = local_date.new_offset(0)
    
    # Set the converted UTC DateTime to midnight (00:00:00)
    utc_date = DateTime.new(utc_date.year, utc_date.month, utc_date.day, 0, 0, 0, 0)
    
    @photo = Photo.find_by(date: utc_date)
    puts "!!!!!!!!!!!!!!!!!"
    puts @photo.date.to_datetime

    if @photo.date.to_datetime == utc_date
      puts "formatted_nasa_date == users_current_time_to_midnight_utc"
    else
      puts "formatted_nasa_date != users_current_time_to_midnight_utc"
    end
  end

  def convertNasaDateToUtcDateTime()
    formatted_nasa_date = DateTime.strptime("#{data["date"]} 00:00:00", "%Y-%m-%d %H:%M:%S")
    return formatted_nasa_date
  end
end
