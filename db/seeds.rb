# utf-8

puts '*********** Seed initialize ****************'

puts "\n"
puts "\n"


puts '=== Countries fakers creator ==='

puts "\n"
puts "\n"

COUNTRIES = [
    {
      name: 'Brazil',
      latitude: -33.7517484,
      longitude: -73.982817,
      code: 'BR'
    },
    {
      name: 'United States',
      latitude: 25.82,
      longitude: -124.39,
      code: 'US'
    }
]

COUNTRIES.each do |country|
  country = Country.create(
      name: country[:name],
      latitude: country[:latitude],
      longitude: country[:longitude],
      code: country[:code]
  )
  puts "Country #{country.name} created with success!"
end

puts "\n"
puts "\n"



puts '=== States fakers creator ==='

puts "\n"
puts "\n"

STATES = [
    {
        name: 'Rio de Janeiro',
        code: 'RJ',
        latitude: -11.8048222802915,
        longitude: -46.0550868802915,
        country_name: 'Brazil',
        country_code: 'BR'
    },
    {
        name: 'New York',
        code: 'NY',
        latitude: 40.91525559999999,
        longitude: -73.70027209999999,
        country_name: 'United States',
        country_code: 'US'
    }
]

STATES.each do |state|
  state = State.create(
      name: state[:name],
      latitude: state[:latitude],
      longitude: state[:longitude],
      country_name: state[:country_name],
      country_code: state[:country_code]
  )
  puts "State #{state.name} created with success!"
end

puts "\n"
puts "\n"



puts '=== Cities fakers creator ==='

puts "\n"
puts "\n"

CITIES = [
    {
        name: 'Rio de Janeiro',
        latitude: -22.9147443802915,
        longitude: -43.2020590802915,
        state_name: 'Rio de Janeiro',
        state_code: 'RJ',
        country_name: 'Brazil',
        country_code: 'BR'
    },
    {
        name: 'Albany',
        latitude: 42.6139008,
        longitude: -73.898099,
        state_name: 'New York',
        state_code: 'NY',
        country_name: 'United States',
        country_code: 'US'
    }
]

CITIES.each do |city|
  city = City.create(
      name: city[:name],
      latitude: city[:latitude],
      longitude: city[:longitude],
      state_name: city[:state_name],
      state_code: city[:state_code],
      country_name: city[:country_name],
      country_code: city[:country_code],
      address: "#{city[:name]} #{city[:state_name]} #{city[:country_name]}",
      launch: true
  )
  puts city.save ? "City #{city.name} created with success!" : 'Error on create city'
end

puts "\n"
puts "\n"


puts '=== Neighborhoods fakers creator ==='

puts "\n"
puts "\n"


NEIGHBORHOODS = [
    {
        name: 'Copacabana',
        city_name: 'Rio de Janeiro',
        latitude: -22.9586588,
        longitude: -43.1724355,
        state_name: 'Rio de Janeiro',
        state_code: 'RJ',
        country_name: 'Brazil',
        country_code: 'BR'
    },
    {
        name: 'Park South',
        city_name: 'Albany',
        latitude: 42.650379,
        longitude: -73.7793652,
        state_name: 'New York',
        state_code: 'NY',
        country_name: 'United States',
        country_code: 'US'
    }
]

NEIGHBORHOODS.each do |neighborhood|
  neighborhood = Neighborhood.create(
      name: neighborhood[:name],
      latitude: neighborhood[:latitude],
      longitude: neighborhood[:longitude],
      city_name: neighborhood[:city_name],
      state_name: neighborhood[:state_name],
      state_code: neighborhood[:state_code],
      country_name: neighborhood[:country_name],
      country_code: neighborhood[:country_code],
  )
  puts "Neighborhood #{neighborhood.name} created with success!"
end

puts "\n"
puts "\n"



puts '=== Personas fakers creator ==='

puts "\n"
puts "\n"

PERSONAS = ["Entrepreneur", "Gourmet", "Nerd", "Activist", "Actor", "Athlete"]

PERSONAS.each do |name|
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

LEVELS = {
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

LEVELS.each do |key, hash|
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

CATEGORIES = ["Leisure", "Health", "Sport", "Education", "Culture", "Food"]

CATEGORIES.each do |name|
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

WEEKS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
n = 1
i = 6

WEEKS.each do |name|
  week = Week.create(
      name: name,
      slug: name.downcase,
      organizer_id: n,
      binary: i
  )
  n += 1
  i -= 1
  puts "Week #{week.name} created with success!"
end

puts "\n"
puts "\n"



puts '=== Places fakers creator ==='

puts "\n"
puts "\n"


PLACES = [
    {
        name: 'Belmond Copacabana Palace',
        route: 'Av. Atlântica',
        street_number: '1702',
        neighborhood_name: 'Copacabana',
        city_name: 'Rio de Janeiro',
        latitude: -22.967816,
        longitude: -43.179073,
        state_name: 'Rio de Janeiro',
        state_code: 'RJ',
        country_name: 'Brazil',
        country_code: 'BR',
        address: 'Av. Atlântica, 1702 - Copacabana, Rio de Janeiro - RJ, 22021-001'
    },
    {
        name: 'New York State Museum',
        route: 'Madison Ave',
        street_number: '222',
        neighborhood_name: 'Park South',
        city_name: 'Albany',
        latitude: 42.6497478302915,
        longitude: -73.7614809697085,
        state_name: 'New York',
        state_code: 'NY',
        country_name: 'United States',
        country_code: 'US',
        address: '222 Madison Ave, Albany, NY 12230, Estados Unidos'
    }
]

PLACES.each do |place|
    place = Place.create(
        name: place[:name],
        latitude: place[:latitude],
        longitude: place[:longitude],
        neighborhood_name: place[:neighborhood_name],
        city_name: place[:city_name],
        state_name: place[:state_name],
        state_code: place[:state_code],
        country_name: place[:country_name],
        country_code: place[:country_code],
        address: place[:address]
    )
    puts "Place #{place.name} created with success!"
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
    username: 'john-doe',
    password: 'password',
    password_confirmation: 'password',
    latitude: nil,
    longitude: nil,
    route: nil,
    street_number: nil,
    neighborhood_name: nil,
    city_name: nil,
    postal_code: nil,
    state_name: nil,
    state_code: nil,
    country_name: nil,
    country_code: nil,
    address: Place.first.address,
    formatted_address: nil,
    admin: true,
    invited: true,
    account_complete: false,
    level_id: 1,
    persona_id: Persona.first.id
)

admin.personas << Persona.first

puts admin.save ? 'The admin is created with success' : 'Error: the admin is not created'

puts "\n"
puts "\n"



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

30.times do
  place = Place.order("RANDOM()").first
  faker_address = Faker::Address
  event = Event.create(
      name: Faker::Lorem.sentence(2, false, 4),
      description: Faker::Lorem.paragraph(5..20),
      date_start: Faker::Date.between(30.days.ago, Date.today),
      date_finish: Faker::Date.between(Date.today, 60.days.from_now),
      hour_start_first: Faker::Time.between(Date.today, Date.tomorrow, :all),
      cost: Faker::Commerce.price,
      cost_details: Faker::Lorem.paragraph(1),
      latitude: faker_address.latitude,
      longitude: faker_address.longitude,
      route: faker_address.street_address,
      street_number: faker_address.building_number,
      neighborhood_name: place.neighborhood_name,
      city_name: place.city_name,
      postal_code: faker_address.postcode,
      state_name: place.state_name,
      state_code: place.state_code,
      country_name: place.country_name,
      country_code: place.country_code,
      address: place.address,
      formatted_address: nil,
      user_id: User.order("RANDOM()").first.id,
      place_id: place.id,
      moderate: 1,
      image: File.new("#{Rails.root}/app/assets/images/default-event-image.jpg")
  )
  puts event.save ? "Event #{event.name} created with success!" : 'Error on create event'
end

puts "\n"
puts "\n"

puts Event.last.latitude.nil? ? 'ERROR: You need access to internet to seed' : 'OK: Events are geocoded with success'

puts "\n"
puts "\n"

Event.all.each do |event|
    weeks = Week.order("RANDOM()")
    event.weeks << [weeks[0], weeks[1], weeks[2]]
    puts event.weeks.count > 0 ? 'Weeks added with success' : 'Error on added weeks'
end


puts "\n"
puts "\n"

Event.all.each do |event|
    categories = Category.order("RANDOM()")
    event.categories << [categories[0], categories[1]]
    puts event.categories.count > 0 ? 'Categories added with success' : 'Error on added categories'
end

puts "\n"
puts "\n"

Event.all.each do |event|
    personas = Persona.order("RANDOM()")
    event.personas << [personas[0], personas[1]]
    puts event.personas.count > 0 ? 'Personas added with success' : 'Error on added personas'
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

