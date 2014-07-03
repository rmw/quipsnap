require 'faker'

2.times do
  user = User.create(username: Faker::Internet.user_name, 
                    auth_token: Faker::Lorem.characters(10), 
                    auth_secret: Faker::Lorem.characters(10)
                    )

  2.times do
    user.quotes << Quote.create(content: Faker::Lorem.sentence, 
                                author: Faker::Name.name, 
                                title: Faker::Commerce.product_name
                                )
  end
end

