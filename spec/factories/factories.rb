FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "testemail#{n}@test.com" }
    password  { "testpassword" }
    password_confirmation { "testpassword" }
  end

  factory :gram do
    message { "Hello!" }
    image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'image.png').to_s, 'image/png') }
    association :user
  end
end