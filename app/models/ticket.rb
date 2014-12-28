class Ticket < ActiveRecord::Base

  validates :sub_id, :customer_name, :customer_email, :subject, :message,
    presence: true

  validates :sub_id,
    uniqueness: true

  after_initialize :set_sub_id, :if => :new_record?

  has_many :ticket_histories

  def to_param
    "#{sub_id}"
  end

  def status
    ticket_histories.last.status || Status.initial.first
  end

  private

  def set_sub_id
    self.sub_id = "#{random_chars}-#{SecureRandom.hex(1)}-#{random_chars}-#{SecureRandom.hex(1)}-#{random_chars}".upcase
  end

  def random_chars
    # Thanks to stackoverflow :)
    (0...3).map { (65 + rand(26)).chr }.join
  end
end
