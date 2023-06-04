class DueDateNotificationJob
  include Sidekiq::Job

  def perform
    BookLoan.where(due_date: Date.tomorrow, status: 'checked_out').each do |book_loan|
      UserMailer.due_date_notification_email(book_loan).deliver_now
    end
  end

end
