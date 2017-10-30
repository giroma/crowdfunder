FactoryGirl.define do
  factory :project do
    title Faker::App.name
    description Faker::Lorem.paragraph
    goal 5666
    start_date(Time.now )
    end_date(Time.now.utc + 1.month)
    user_id 6
  end
end
