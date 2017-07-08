FactoryGirl.define do

  factory :message do
    body        { Faker::StarWars.wookie_sentence }
    image       { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/image/hari.jpg')) }
    user_id     { Faker::Number.number(1) }
    group_id    { Faker::Number.number(1) }
    created_at  { Faker::Time.between(2.days.ago, Date.today, :afternoon) }
    user
    group
  end
end
