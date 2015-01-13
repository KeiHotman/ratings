FactoryGirl.define do
  factory :user do
    sequence(:name){|n| "User#{n}" }
    grade 1
    department 'information'

    factory :invalid_user do
      name ''
    end
  end
end
