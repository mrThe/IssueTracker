class TicketHistory < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :owner, class_name: User
  belongs_to :status

  validates :user, :status,
    presence: true

  before_validation :set_last_status, :if => proc { self.status.nil? }
  before_validation :set_last_owner
  after_save        :set_owner_for_ticket, :if => proc { take_ownership? }
  after_save        :set_status_for_ticket

  attr_accessor :take_ownership

  def take_ownership?
    take_ownership == "1"
  end

  def owner_name
    owner.name rescue 'None'
  end

  private

  def set_owner_for_ticket
    self.ticket.set_owner! user
  end

  def set_status_for_ticket
    self.ticket.set_status! status
  end

  def set_last_owner
    self.owner = take_ownership? ? user : ticket.owner
  end

  def set_last_status
    self.status = ticket.status
  end
end
