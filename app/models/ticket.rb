class Ticket < ActiveRecord::Base
  include PgSearch

  validates :sub_id, :customer_name, :customer_email, :subject, :message,
    presence: true

  validates :sub_id,
    uniqueness: true

  after_initialize :set_sub_id, :if => :new_record?
  after_initialize :set_initial_status, :if => :new_record?

  has_many   :ticket_histories
  belongs_to :owner, class_name: User
  belongs_to :status

  scope :unassigned, -> { where(owner: nil) }
  scope :open,       -> { where(status: Status.open) }
  scope :on_hold,    -> { where(status: Status.on_hold) }
  scope :completed,  -> { where(status: Status.all_completed) }


  pg_search_scope :fulltext_search, :against => [:sub_id, :subject, :message]

  def self.search(query)
    if query.present?
      fulltext_search(query)
    else
      all
    end
  end

  def to_param
    "#{sub_id}"
  end

  def set_owner!(owner)
    self.owner = owner

    self.save!
  end

  def set_status!(status)
    self.status = status

    self.save!
  end

  def owner_name
    owner.try(:name) || 'None'
  end

  private

  def set_initial_status
    self.status = Status.initial_status
  end

  def set_sub_id
    self.sub_id = "#{random_chars}-#{SecureRandom.hex(1)}-#{random_chars}-#{SecureRandom.hex(1)}-#{random_chars}".upcase
  end

  def random_chars
    # Thanks to stackoverflow :)
    (0...3).map { (65 + rand(26)).chr }.join
  end
end
