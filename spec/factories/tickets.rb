FactoryGirl.define do
  factory :ticket do
    customer_name  Faker::Name.name
    customer_email Faker::Internet.email
    subject        Faker::Lorem.sentence
    message        Faker::Lorem.paragraph
  end

end
