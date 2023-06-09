FactoryBot.define do
  factory :subscription do
    title { Faker::Coffee.blend_name }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    status { 0 }
    frequency { 0 }
    customer { nil }
    tea { nil }
  end
end
