class CreateTicketHistories < ActiveRecord::Migration
  def change
    create_table :ticket_histories do |t|
      t.references :ticket, index: true
      t.references :user,   index: true
      t.references :status, index: true
      t.text :message

      t.timestamps
    end
  end
end
