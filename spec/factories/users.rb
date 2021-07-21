FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :admin, class: User do
      is_admin { true }
    end
  end
end
