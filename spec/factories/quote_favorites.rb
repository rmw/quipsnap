# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quote_favorite do
    user
    quote
  end
end
