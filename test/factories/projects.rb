FactoryGirl.define do
  factory :project do
    name Faker::App.name
    team
  end
end
