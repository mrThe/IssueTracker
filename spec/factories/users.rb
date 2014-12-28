FactoryGirl.define do
  factory :user do
    name      Faker::Name.name
    email     { SecureRandom.hex(5) + Faker::Internet.email }
    password  "password123"

    trait :admin do
      role :admin
    end

  end
end
