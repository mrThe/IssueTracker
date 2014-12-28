class Status < ActiveRecord::Base
  enum flag: [ :initial, :waiting, :hold, :completed, :cancelled ]

  has_many :ticket_histories
end
