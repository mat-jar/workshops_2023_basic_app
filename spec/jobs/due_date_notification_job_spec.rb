require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe DueDateNotificationJob, type: :job do
  describe 'perform' do
    it 'runs' do
      create_list(:book_loan, 3, due_date: Date.tomorrow)
      Sidekiq::Testing.inline! do
        described_class.perform_async
      end
      expect(ActionMailer::Base.deliveries.count).to eql(3)
    end
  end
end
