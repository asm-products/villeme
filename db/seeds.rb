# utf-8

puts '*********** Seed initialize ****************'

puts "\n"
puts "\n"


puts '=== Cities and Neighborhoods fakers creator ==='

puts "\n"
puts "\n"

3.times do
  faker_address = Faker::Address
  city = City.create(
      name: faker_address.city,
      address: faker_address.street_address,
      latitude: faker_address.latitude,
      longitude: faker_address.longitude,
  )
  3.times do
    city.neighborhoods << Neighborhood.create(
        name: faker_address.city,
        address: faker_address.street_address,
        latitude: faker_address.latitude,
        longitude: faker_address.longitude,
    )
  end
  puts "City #{city.name} with #{city.neighborhoods.count} neighborhoods created with success!"
end

puts "\n"
puts "\n"


puts '=== Personas fakers creator ==='

puts "\n"
puts "\n"

persona_names = ["Entrepreneur", "Gourmet", "Nerd", "Activist", "Actor", "Athlete"]

persona_names.each do |name|
  persona = Persona.create(
      name: name
  )
  puts "Persona #{persona.name} created with success!"
end

puts "\n"
puts "\n"


puts '=== Levels fakers creator ==='

puts "\n"
puts "\n"

levels = {
    egg: {
        name: 'Egg',
        slug: 'egg',
        points: 0,
        nivel: 1
    },
    little_chicken: {
        name: 'Little chicken',
        slug: 'little-chicken',
        points: 30,
        nivel: 2
    },
    wood_hammer:{
        name: 'Wood hammer',
        slug: 'wood-hammer',
        points: 42,
        nivel: 3
    }
}

levels.each do |key, hash|
  level = Level.create(
      name: hash[:name],
      slug: hash[:slug],
      points: hash[:points],
      nivel: hash[:nivel]
  )
  puts "Level #{level.name} created with success!"
end

puts "\n"
puts "\n"


puts '=== Categories fakers creator ==='

puts "\n"
puts "\n"

categories = ["Leisure", "Health", "Sport", "Education", "Culture", "Food"]

categories.each do |name|
  category = Category.create(
      name: name
  )
  puts "Category #{category.name} created with success!"
end

puts "\n"
puts "\n"


puts '=== Weeks fakers creator ==='

puts "\n"
puts "\n"

weeks = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
n = 1

weeks.each do |name|
  week = Week.create(
      name: name,
      slug: name.downcase,
      organizer_id: n
  )
  n += 1
  puts "Week #{week.name} created with success!"
end

puts "\n"
puts "\n"


puts '=========== Users fakers creator ==========='

puts "\n"
puts "\n"

faker_address = Faker::Address
admin = User.create(
    name: 'John Doe',
    email: 'admin@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    latitude: faker_address.latitude,
    longitude: faker_address.longitude,
    admin: true,
    invited: true,
    city_id: City.first.id,
    level_id: 1,
    persona_id: Persona.first.id
)


8.times do
  password = Faker::Internet.password(8, 20)
  user = User.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password,
      latitude: faker_address.latitude,
      longitude: faker_address.longitude,
      invited: true,
      city_id: City.first.id,
      level_id: 1,
      persona_id: Persona.order("RANDOM()").first.id
  )
  puts "User #{user.name} created with success!"
end

puts "\n"
puts "\n"



puts '=========== Events fakers creator ==========='

puts "\n"
puts "\n"

10.times do
  faker_address = Faker::Address
  event = Event.create(
      name: Faker::Lorem.sentence(4, false, 6),
      description: Faker::Lorem.paragraph(5),
      address: faker_address.street_address,
      date_start: Faker::Date.between(30.days.ago, Date.today),
      date_finish: Faker::Date.between(Date.today, 60.days.from_now),
      hour_start_first: Faker::Time.between(Date.today, Date.tomorrow, :all),
      latitude: faker_address.latitude,
      longitude: faker_address.longitude,
      number: faker_address.building_number,
      cost: Faker::Commerce.price,
      cost_details: Faker::Lorem.paragraph(1),
      full_address: faker_address.street_address,
      city_name: faker_address.city,
      country: faker_address.country,
      country_code: faker_address.country_code,
      postal_code: faker_address.postcode,
      state: faker_address.state,
      state_code: faker_address.state_abbr,
      neighborhood_name: Faker::Lorem.word,
      user_id: User.order("RANDOM()").first.id,
      moderate: 1
  )
  puts "Event #{event.name} created with success!"
end

puts "\n"
puts "\n"

puts '=========== Admin access ==============='

puts "\n"
puts "\n"

if admin.save
	puts "User admin crated with email: #{admin.email} and password: #{admin.password} \n"
	puts 'You can use this user to login at the app visiting localhost:3000/sign_in'
else
	puts "It's not possible to create the Admin"
end

