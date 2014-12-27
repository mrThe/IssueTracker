class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :sub_id,         null: false
      t.string :customer_name,  null: false
      t.string :customer_email, null: false
      t.string :subject,        null: false
      t.text   :message,        null: false

      t.timestamps
    end

    add_index :tickets, :sub_id, unique: true
  end
end
