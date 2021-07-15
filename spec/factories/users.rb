FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
