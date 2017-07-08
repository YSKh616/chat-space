FactoryGirl.define do
  pass = Faker::Internet.password(8)
  factory :user do
     name                  { Faker::StarWars.character }
     email                 { Faker::Internet.email }
     password              pass
     password_confirmation pass
  end
end
