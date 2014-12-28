FactoryGirl.define do
  factory :status do
    name Faker::Lorem.word
    flag :completed

    trait :initial do
      flag :initial
    end

    trait :waiting do
      flag :waiting
    end

    trait :on_hold do
      flag :on_hold
    end

    trait :completed do
      flag :completed
    end

    trait :cancelled do
      flag :cancelled
    end


  end
end
