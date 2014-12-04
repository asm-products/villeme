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
    city_name "Nova York"
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
    city_name "Nova York"
    persona
  end


  factory :city do
    name "Nova York"
    slug "ny"
  end

  factory :persona do
    name "Entrepreuner"
  end

  factory :invite do
    email "user@gmail.com"
    name "John Doe"
    persona "Entrepreuner"
    address "Rua Rivadavia Correia, 08 - Partenon"
  end


end