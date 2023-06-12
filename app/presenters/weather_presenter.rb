class WeatherPresenter

def initialize(ip_address)
  @ip_address = ip_address
end

def encourage_text
  if good_to_read_outside?
    "Get some snacks and go read a book in a park!"
  else
    "It's always good weather to read a book!"
  end
end

def description
  weather_data.dig("current", "condition", "text")
end

def temperature
  weather_data.dig("current", "temp_c")
end

def icon
  weather_data.dig("current", "condition", "icon")
end

def location
  weather_data.dig("location", "name")
end

private

def nice_weather?
  description == 'Sunny' || description =='Partly cloudy'
end

def good_to_read_outside?
  nice_weather? && temperature > 15
end

def weather_data
    @weather_data ||= WeatherApiConnector.new.weather_data(@ip_address)
end

end
