FactoryGirl.define do
  factory :status do
    name Faker::Lorem.word
    flag :completed
  end
end
