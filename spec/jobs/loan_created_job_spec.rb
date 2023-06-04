require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe LoanCreatedJob, type: :job do
  describe 'perform' do
    it 'runs' do
      book_loan = create(:book_loan)
      Sidekiq::Testing.inline! do
        described_class.perform_async(book_loan.id)
      end
      expect(ActionMailer::Base.deliveries.count).to eql(1)
    end
  end
end
