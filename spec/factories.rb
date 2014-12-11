FactoryGirl.define do
  factory :user do
    name "John Doe"
    email "user@gmail.com"
    locale "en"
    account_complete true
    invited true
    admin false
    latitude 0.000
    longitude 0.000
    password "password"
    password_confirmation "password"
    neighborhood_name "Park South"
    city_name "Albany"
    state_name "New York"
    country_name "United States"
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    name "Admin"
    email "admin@gmail.com"
    locale "en"
    password "password"
    password_confirmation "password"
    account_complete true
    invited true
    admin true
    city_name "Albany"
    persona
  end


  factory :event do
    name "Campus Party"
    neighborhood_name "Park South"
    city_name "Albany"
    state_name "New York"
    country_name "United States"
    country_code "US"
    address "544 Madison Ave, Albany, NY 12208, USA"
    latitude 42.6531078197085
    longitude -73.7729633802915
    date_start Faker::Date.between(30.days.ago, Date.today)
    hour_start_first Faker::Time.between(Date.today, Date.tomorrow, :all)
    place
    image_file_name 'test.jpg'
    image_content_type 'image/jpg'
    image_file_size 1024
  end

  factory :place do
    name "New York State Museum"
    neighborhood_name "Park South"
    city_name "Albany"
    state_name "New York"
    country_name "United States"
    country_code "US"
    address "544 Madison Ave, Albany, NY 12208, USA"
    latitude 42.6531078197085
    longitude -73.7729633802915
  end

  factory :city do
    name "Albany"
  end

  factory :neighborhood do
    name "Park South"
    city_name "Albany"
    state_name "New York"
    country_name "United States"
  end

  factory :state do
    name "New York"
  end

  factory :country do
    name "United States"
  end

  factory :persona do
    name "Entrepreuner"
  end

  factory :invite do
    email "user@gmail.com"
    name "John Doe"
    persona "Entrepreuner"
    neighborhood_name "Park South"
    city_name "Albany"
    state_name "New York"
    country_name "United States"
    country_code "US"
    address "544 Madison Ave, Albany, NY 12208, USA"
    latitude 42.6531078197085
    longitude -73.7729633802915
    key "qowiqmas01231ljadao"
  end



end