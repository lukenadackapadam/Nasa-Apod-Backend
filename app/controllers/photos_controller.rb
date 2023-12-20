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
    # Create a DateTime object in user's local timezone
    local_date = DateTime.now

    utc_date = local_date.in_time_zone("UTC").beginning_of_day

    date_time_minus_one_millisecond = utc_date - Rational(1, 1000 * 60 * 60 * 24)
    formatted_date_time = date_time_minus_one_millisecond.strftime('%Y-%m-%d 00:00:00 %Z')

    photo = Photo.find_by(date: formatted_date_time)

    if photo && photo.date == formatted_date_time
      render json: photo
    else
      create()
    end
  end
end
