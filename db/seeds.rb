# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


10.times do 

  title = Faker::Lorem.words(5)
  description = Faker::Lorem.sentences(4)
  price = rand(400..600)
  inventory = rand(0..10)

  Card.create(title:       title, 
              description: description, 
              price:       price, 
              inventory:   inventory)

end

Admin.create(email: "admin@inkwell.com", password: "cardmaster")

10.times do 

  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  name = first_name + " " + last_name

  params = { first_name:     first_name,
             last_name:      last_name,
             email:          Faker::Internet.email(name),
             password:       "password",
             street_address: Faker::Address.street_address,
             city:           Faker::Address.city,
             state:          Faker::Address.state_abbr,
             zipcode:        Faker::Address.zip_code}

  User.create(params)

end

users = User.all

5.times do 

  users.each do |user|

    params = { first_name:     Faker::Name.first_name,
               last_name:      Faker::Name.last_name,
               street_address: Faker::Address.street_address,
               city:           Faker::Address.city,
               state:          Faker::Address.state_abbr,
               zipcode:        Faker::Address.zip_code}

    user.friends << Friend.create(params)
  end
  
end

def datetime_rand from = Time.now, to = Time.now + 6.months
  Time.at(from + rand * (to.to_f - from.to_f))
end

users.each do |user|
  user.friends.each do |friend|
    name = friend.first_name + " " + friend.last_name
    friend.occasions << Occasion.create(date: datetime_rand, name:"#{name.titleize}'s Birthday", event_type_name: "birthday")
  end
end

half_of_occasions = Occasion.all.select {|occasion| occasion.id.odd?}

half_of_occasions.each do |occasion|
  Card.all.sample.orders << Order.create(user_id: occasion.friend.user.id, occasion_id: occasion.id)
end

Tag.create(name: "anniversary")
Tag.create(name: "birthday")

Card.all.each do |card|
  card.tags << Tag.all.sample
end

