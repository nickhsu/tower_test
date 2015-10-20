FactoryGirl.define do
  factory :access do
    user
    project
    role "admin"
  end
end
