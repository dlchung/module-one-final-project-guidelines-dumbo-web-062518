class Location <ActiveRecord::Base
  has_many :trainers, through: :visits
  has_many :encounters, through: :visits
  has_many :visits

  def self.fetch_location(lat = active_trainer.latitude,lon = active_trainer.longitude)
    api_key = 'da3fa0ef987e099623458219b705d9fe'
    # binding.pry
    # url = "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{api_key}"
    url = "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{api_key}"
    response = RestClient.get(url)
    JSON.parse(response)
  end

  def self.fetch_weather(lat, lon)
    self.fetch_location(lat, lon)["weather"][0]["description"]
  end

  def self.weather_pokemon(lat, lon)
    self.fetch_location(lat, lon)["weather"][0]["main"]
  end

  def self.fetch_weather_icon(lat, lon)
    weather_icon = self.fetch_location(lat, lon)["weather"][0]["icon"]
    Catpix::print_image "http://openweathermap.org/img/w/#{weather_icon}.png",
      :limit_x => 0.5,
      :limit_y => 0.5,
      :center_x => false,
      :center_y => false,
      :resolution => "high"
  end

end
