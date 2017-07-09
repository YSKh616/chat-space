FactoryGirl.define do
  pass = Faker::Internet.password
  factory :user do
    name                  { Faker::StarWars.character }
    email                 { Faker::Internet.email }
    password              pass
    password_confirmation pass
  end
end
