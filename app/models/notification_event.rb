class NotificationEvent < ApplicationRecord
  validates :event_id, presence: true

  belongs_to :book_loan
end
