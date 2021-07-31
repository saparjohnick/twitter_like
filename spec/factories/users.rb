FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { Time.now }

    factory :admin, class: User do
      is_admin { true }
    end

    trait :with_relationship do
      transient do
        followed_id { nil }
      end

      after(:create) do |user, evaluator|
        user.active_relationships.create(followed_id: evaluator.followed_id)
      end
    end
  end
end
