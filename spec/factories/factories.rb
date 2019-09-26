FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "testemail#{n}@test.com" }
    password  { "testpassword" }
    password_confirmation { "testpassword" }
  end

  factory :gram do
    message { "Hello!" }
    association :user
  end
end