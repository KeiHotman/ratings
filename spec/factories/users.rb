FactoryGirl.define do
  factory :user do
    sequence(:name){|n| "User#{n}" }
    grade 1
    department 'information'
    sequence(:email){|n| "user#{n}@example.com"}
    password 'password'

    factory :invalid_user do
      name ''
    end
  end
end
