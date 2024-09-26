class IpgeolocationApiConnector

API_KEY = A9n.ipgeolocation_api_key

  def find_location(ip_address)
    uri = URI("https://ipgeolocation.abstractapi.com/v1/?api_key=#{API_KEY}&ip_address=#{ip_address}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    JSON.parse(response.body)["city"]
  rescue StandardError => error
    puts "Error (#{ error.message })"
  end

end
