class AddOwnerReferenceToTicketHistory < ActiveRecord::Migration
  def change
    add_reference :ticket_histories, :owner, index: true
  end
end
