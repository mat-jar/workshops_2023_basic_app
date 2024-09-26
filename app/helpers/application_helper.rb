module ApplicationHelper
  def reserve_book_button(book, css_class: '')
    return unless book.reservation_available_for?(current_user)

    button_to(
      'Reserve (book is already loaned)',
      book_reservations_path(book_id: book.id),
      method: :post,
      class: "btn #{css_class}"
    )
  end

  def loan_book_button(book, css_class: '')
    return unless book.loan_available_for?(current_user)

    button_to(
      'Loan',
      book_loans_path(book_id: book.id),
      method: :post,
      class: "btn #{css_class}"
    )
  end

  def weather_presenter
    ip_address = request.env['HTTP_FLY_CLIENT_IP'] || request.remote_ip
    @weather_presenter ||= WeatherPresenter.new(ip_address)
  end

end
