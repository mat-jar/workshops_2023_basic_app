FactoryBot.define do
  factory :book_loan do
    due_date { Time.zone.today + 14.days }
    book
    user
  end
end
