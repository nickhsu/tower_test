FactoryGirl.define do
  factory :user_a, class: User do
    name Faker::Name.name
    email Faker::Internet.email
    password "password"
    password_confirmation "password"
    association :team, :factory => :team
  end

  factory :user_b, class: User do
    name Faker::Name.name
    email Faker::Internet.email
    password "password"
    password_confirmation "password"
    association :team, :factory => :team
  end
end
