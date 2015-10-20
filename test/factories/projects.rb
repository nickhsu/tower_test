FactoryGirl.define do
  factory :project do
    transient do
      users []
    end

    name { Faker::App.name }
    team

    after(:create) do |project, evaluator|
      evaluator.users.each { |u| create(:access, project: project, user: u) }
    end
  end
end
