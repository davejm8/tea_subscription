FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Lorem.paragraph }
    temperature { Faker::Number.between(from: 1, to: 100) }
    brew_time { Faker::Number.between(from: 1, to: 100) }
  end
end
