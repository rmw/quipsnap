# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bookclub, :class => 'Bookclub' do
    name { Faker::Company.name }
    description { Faker::Company.catch_phrase }
  end
end
