class CreateNotificationEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_events do |t|
      t.string :event_id
      t.references :book_loan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
