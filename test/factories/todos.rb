FactoryGirl.define do
  factory :todo do
    title { Faker::Hacker.say_something_smart }
    description { Faker::Hacker.say_something_smart }
    project

    association :creator, :factory => :user
  end

end
