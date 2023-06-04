class UserMailer < ApplicationMailer

  def loan_created_email(book_loan)
    @title = book_loan.book.title
    @due_date = book_loan.due_date
    @user_email = book_loan.user.email

    email_subject = "New book loan succeeded"

    mail(to: @user_email, subject: email_subject)
  end

  def due_date_notification_email(book_loan)
    @title = book_loan.book.title
    @loan_date = book_loan.created_at
    @user_email = book_loan.user.email

    email_subject = "A book " + @title + " must be returned tomorrow"

    mail(to: @user_email, subject: email_subject)

  end

end
