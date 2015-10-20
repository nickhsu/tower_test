FactoryGirl.define do
  factory :project_a, class: Project do
    name Faker::App.name
    association :team, :factory => :team
  end

  factory :project_b, class: Project do
    name Faker::App.name
    association :team, :factory => :team
  end
end
