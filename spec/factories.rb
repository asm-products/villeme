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
    city_name "Nova York"
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    name "Admin"
    email "admin@gmail.com"
    locale "en"
    account_complete true
    invited true
    admin true
  end


  factory :city do
    name "Nova York"
    slug "ny"
  end


end