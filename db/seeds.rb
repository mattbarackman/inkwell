
system("rake etsy:refresh")

Admin.create(email: "admin@inkwell.com", password: "cardmaster")
User.create(email: "user@inkwell.com", password: "password")

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

5.times do 

  User.all.each do |user|

    params = { name:           Faker::Name.name,
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

User.all.each do |user|
  user.friends.each do |friend|
    p name = friend.name
    occasion = friend.occasions.build(date: datetime_rand, name:"#{name.titleize}'s Birthday", event_type_name: "birthday")
    occasion.save
  end
end

Occasion.all.each do |occasion|
  Card.all.sample.orders << Order.create(user_id: occasion.friend.user.id, occasion_id: occasion.id, event_date: occasion.date)
end

Tag.create(name: "anniversary")
Tag.create(name: "birthday")
Tag.create(name: "graduation")

Card.all.each do |card|
  card.tags << Tag.all.sample
end

