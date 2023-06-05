class Publishers::LoanBookPublisher

  def initialize(message:, action:)
    @message = message
    @action = action
  end

  def publish
    routing_key = "basic_app.book_loans.#{@action}"
    @message["routing_key"] = routing_key
    return if ["create", "cancel"].exclude? @action
    ::Publishers::Application.new(
    routing_key: routing_key,
    exchange_name: "basic_app",
    message: @message
    ).perform
  end

end
