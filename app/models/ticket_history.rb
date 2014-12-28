class TicketHistory < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :owner, class_name: User
  belongs_to :status

  validates :user, :status, :message,
    presence: true

  before_validation :set_last_status, :if => proc { self.status.nil? }
  after_save        :set_status_for_ticket
  after_save        :set_owner_for_ticket

  def owner_name
    owner.name rescue 'None'
  end

  private

  def set_owner_for_ticket
    self.ticket.set_owner! owner
  end

  def set_status_for_ticket
    self.ticket.set_status! status
  end

  def set_last_status
    self.status ||= ticket.status
  end
end
