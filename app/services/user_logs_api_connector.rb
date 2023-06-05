class UserLogsApiConnector

  def user_logs(user)
    user_id = user.id
    url = "http://localhost:3001/api/v1/logs/user/#{user_id}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

end
