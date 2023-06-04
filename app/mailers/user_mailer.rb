class UserMailer < ApplicationMailer

  def loan_created_email(book_loan)
    @title = book_loan.book.title
    @due_date = book_loan.due_date
    @user_email = book_loan.user.email

    email_subject = "New book loan succeeded"

    mail(to: @user_email, subject: email_subject)
  end
end
