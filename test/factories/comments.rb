FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    todo
    user
  end
end
