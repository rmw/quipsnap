FactoryGirl.define do
  factory :quote do
  	content {Faker::Lorem.sentence}
  	author {Faker::Name.name}
  	title {Faker::Commerce.product_name}
  	user
  end
end
