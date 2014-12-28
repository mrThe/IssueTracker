class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string  :name
      t.integer :flag

      t.timestamps
    end
  end
end
