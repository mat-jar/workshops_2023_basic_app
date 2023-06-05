require 'bunny'

class ::Publishers::Application

  def initialize(routing_key:, exchange_name:, message:)
    @routing_key = routing_key
    @exchange_name = exchange_name
    @message = message
  end


  def perform
    connection.start
    channel = connection.create_channel
    channel.direct(@exchange_name).publish(@message.to_json, routing_key: @routing_key)
    connection.close
  end

  private

  def connection
    @connection ||= Bunny.new(A9n.connection_options)
  end
end
