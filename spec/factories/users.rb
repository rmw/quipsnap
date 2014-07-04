FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    auth_token { Faker::Lorem.characters(10) }
    auth_secret { Faker::Lorem.characters(10) }
  end
end
