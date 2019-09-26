FactoryBot.define do
  factory :user do
    email { "testemail@test.com" }
    password  { "testpassword" }
    password_confirmation { "testpassword" }
  end
end