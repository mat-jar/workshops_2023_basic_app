class BookLoansController < ApplicationController
  before_action :set_book_loan, only: %i[cancel]
  before_action :prepare_book_loan, only: %i[create]

  def create
    respond_to do |format|
      if @book_loan.save
        notice_calendar_add
        LoanCreatedJob.perform_async(@book_loan.id)
        Publishers::LoanBookPublisher.new(message: @book_loan.attributes, action: "create").publish
        format.html { redirect_to book_url(book), notice: flash_notice }
        format.json { render :show, status: :created, location: @book_loan }
      else
        format.html { redirect_to book_url(book), alert: @book_loan.errors.full_messages.join(', ') }
        format.json { render json: @book_loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    respond_to do |format|
      if @book_loan.cancelled!
        notice_calendar_delete
        Publishers::LoanBookPublisher.new(message: @book_loan.attributes, action: "cancel").publish
        format.html { redirect_to book_requests_path, notice: flash_notice }
        format.json { render :show, status: :ok, location: book }
      end
    end
  end

  private

  delegate :book, to: :@book_loan

  def prepare_book_loan
    @book_loan = current_user.book_loans.new(book_id: book_loan_params, due_date: Time.zone.today + 14.days)
  end

  def set_book_loan
    @book_loan = current_user.book_loans.find(params[:id])
  end

  def book_loan_params
    params.require(:book_id)
  end

  def notice_calendar_add
    event_id = UserCalendarNotifier.new(user: current_user, book: book).insert_event.id
    NotificationEvent.create(event_id: event_id, book_loan: @book_loan)
  end

  def notice_calendar_delete
    UserCalendarNotifier.new(user: current_user, event_id: @book_loan.notification_event.event_id).delete_event
  end

end
