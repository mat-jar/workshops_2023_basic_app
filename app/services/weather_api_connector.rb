class WeatherApiConnector

API_KEY = A9n.weather_api_key
LOCATION = 'Cracow'

  def weather_data(ip_address)
    location = IpgeolocationApiConnector.new.find_location(ip_address) || LOCATION
    url = "http://api.weatherapi.com/v1/current.json?key=#{API_KEY}&q=#{location}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

end
