FactoryGirl.define do
  factory :todo_a, class: Todo do
    title Faker::Hacker.say_something_smart
    description Faker::Hacker.say_something_smart

    association :creator, :factory => :user_a
    association :project, :factory => :project_a
  end

end
