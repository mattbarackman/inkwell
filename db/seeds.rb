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
