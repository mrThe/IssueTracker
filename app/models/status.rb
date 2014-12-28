class Status < ActiveRecord::Base
  enum flag: [ :initial, :waiting, :on_hold, :completed, :cancelled ]

  scope :all_completed, -> { where(flag: [flags[:completed], flags[:cancelled]]) }
  scope :open, -> { where(flag: [flags[:initial], flags[:waiting]]) }

  has_many :ticket_histories

  def self.initial_status
    Status.initial.first
  end
end
