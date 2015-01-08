FactoryGirl.define do
  factory :user do
    sequence(:name){|n| "User#{n}" }
    grade 1
    department 1
  end
end
