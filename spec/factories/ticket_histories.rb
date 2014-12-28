FactoryGirl.define do
  factory :ticket_history do
    ticket
    user
    status
    message Faker::Lorem.paragraph
  end

end
