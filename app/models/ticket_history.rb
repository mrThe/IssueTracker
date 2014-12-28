class TicketHistory < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :status

  validates :user, :status,
    presence: true

  before_validation :set_last_status, :if => proc { self.status.nil? }

  private

  def set_last_status
    self.status = ticket.status
  end
end
