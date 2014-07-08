FactoryGirl.define do
  factory :quote do
  	content {Faker::Lorem.sentence}
  	goodreads_link {Faker::Internet.url}
  	author
  	user
  	book
  end
end
