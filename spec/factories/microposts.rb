FactoryBot.define do
  factory :micropost do
    content { "MyText" }
    user_id { :user }
  end
end
