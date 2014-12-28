class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable

  enum role: [:staff, :admin, :customer]

  after_initialize :set_default_role, :if => :new_record?

  has_many :ticket_histories
  has_many :tickets, foreign_key: :owner_id

  def can_edit?
    staff? or admin?
  end

  def self.customer_user
    User.customer.first
  end

  private

  def set_default_role
    self.role ||= :staff
  end
end
