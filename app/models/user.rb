class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable

  enum role: [:staff, :admin]

  after_initialize :set_default_role, :if => :new_record?

  has_many :ticket_histories

  def can_edit?
    staff? or admin?
  end

  private

  def set_default_role
    self.role ||= :staff
  end
end
