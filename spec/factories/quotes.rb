# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quote do
  	content {Faker::Lorem.sentence}
  	author {Faker::Name.name}
  	title {Faker::Commerce.product_name}
  	user
  end
end
