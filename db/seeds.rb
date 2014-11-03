# utf-8

puts '*********** Seed initialize ****************'

"\n"
"\n"

puts '=========== Users fakers creator ==========='

"\n"
"\n"

admin = User.new(
    :email => "admin@gmail.com",
    :password => 'password',
    :password_confirmation => 'password'
)
admin.save

20.times do
  password = Faker::Internet.password(8, 20)
  user = User.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password
  )
  puts "#{user.name} - #{user.email} created with success!"
end

"\n"
"\n"

puts '=========== Events fakers creator ==========='

"\n"
"\n"

10.times do
  event = Event.create(
      name: Faker::Lorem.sentence(4, false, 6),
      description: Faker::Lorem.paragraph(5),
      address: Faker::Address.street_address,
      date_start: Faker::Date.between(30.days.ago, Date.today),
      hour_start_first: Faker::Time.between(Date.today, Date.tomorrow, :all),
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude,
      number: Faker::Address.building_number,
      cost: Faker::Commerce.price,
      cost_details: Faker::Lorem.paragraph(1),
      full_address: Faker::Address.street_address,
      city_name: Faker::Address.city,
      country: Faker::Address.country,
      country_code: Faker::Address.country_code,
      postal_code: Faker::Address.postcode,
      state: Faker::Address.state,
      state_code: Faker::Address.state_abbr,
      neighborhood_name: Faker::Lorem.word
  )
end

"\n"
"\n"

puts '=========== Admin access ==============='

"\n"
"\n"

if admin.save
	puts "User admin crated with email: #{admin.email} and password: #{admin.password} \n"
	puts 'You can use this user to login at the app visiting localhost:3000/sign_in'
else
	puts "It's not possible to create the Admin"
end

