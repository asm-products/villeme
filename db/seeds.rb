# utf-8

puts '*********** Seed initialize ****************'

puts "\n"
puts "\n"


puts '=== Countries fakers creator ==='

puts "\n"
puts "\n"

2.times do
  faker_address = Faker::Address
  faker_name = Faker::Lorem.word
  country = Country.create(
      name: faker_name,
      latitude: faker_address.latitude,
      longitude: faker_address.longitude,
      code: faker_name[0..2].upcase
  )
  puts "Country #{country.name} created with success!"
end

puts "\n"
puts "\n"



puts '=== States fakers creator ==='

puts "\n"
puts "\n"

2.times do
  faker_address = Faker::Address
  country = Country.order("RANDOM()").first
  state = State.create(
      name: Faker::Lorem.word,
      latitude: faker_address.latitude,
      longitude: faker_address.longitude,
      country_name: country.name,
      country_code: country.code
  )
  puts "State #{state.name} created with success!"
end

puts "\n"
puts "\n"



puts '=== Cities fakers creator ==='

puts "\n"
puts "\n"

2.times do
  faker_address = Faker::Address
  country = Country.order("RANDOM()").first
  state = State.order("RANDOM()").first
  city = City.create(
      name: faker_address.city,
      latitude: faker_address.latitude,
      longitude: faker_address.longitude,
      state_name: state.name,
      state_code: state.code,
      country_name: country.name,
      country_code: country.code,
  )
  puts "City #{city.name} created with success!"
end

puts "\n"
puts "\n"


puts '=== Neighborhoods fakers creator ==='

puts "\n"
puts "\n"

2.times do
  faker_address = Faker::Address
  country = Country.order("RANDOM()").first
  state = State.order("RANDOM()").first
  neighborhood = Neighborhood.create(
      name: Faker::Lorem.word,
      latitude: faker_address.latitude,
      longitude: faker_address.longitude,
      city_name: City.order("RANDOM()").first.name,
      state_name: state.name,
      state_code: state.code,
      country_name: country.name,
      country_code: country.code,
  )
  puts "City #{neighborhood.name} created with success!"
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
  week = Category.create(
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
    route: faker_address.street_address,
    street_number: faker_address.building_number,
    neighborhood_name: Neighborhood.order("RANDOM()").first.name,
    city_name: City.order("RANDOM()").first.name,
    postal_code: faker_address.postcode,
    state_name: State.order("RANDOM()").first.name,
    state_code: nil,
    country_name: Country.order("RANDOM()").first.name,
    country_code: nil,
    full_address: faker_address.street_address,
    admin: true,
    invited: true,
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
      route: faker_address.street_address,
      street_number: faker_address.building_number,
      neighborhood_name: Neighborhood.order("RANDOM()").first.name,
      city_name: City.order("RANDOM()").first.name,
      postal_code: faker_address.postcode,
      state_name: State.order("RANDOM()").first.name,
      state_code: nil,
      country_name: Country.order("RANDOM()").first.name,
      country_code: nil,
      full_address: faker_address.street_address,
      invited: true,
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
      date_start: Faker::Date.between(30.days.ago, Date.today),
      date_finish: Faker::Date.between(Date.today, 60.days.from_now),
      hour_start_first: Faker::Time.between(Date.today, Date.tomorrow, :all),
      cost: Faker::Commerce.price,
      cost_details: Faker::Lorem.paragraph(1),
      latitude: faker_address.latitude,
      longitude: faker_address.longitude,
      route: faker_address.street_address,
      street_number: faker_address.building_number,
      neighborhood_name: Neighborhood.order("RANDOM()").first.name,
      city_name: City.order("RANDOM()").first.name,
      postal_code: faker_address.postcode,
      state_name: State.order("RANDOM()").first.name,
      state_code: nil,
      country_name: Country.order("RANDOM()").first.name,
      country_code: nil,
      full_address: faker_address.street_address,
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

