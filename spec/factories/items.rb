FactoryGirl.define do
  factory :item do
    sequence(:name){|n| "Item#{n}" }
    grade 1
    department 1
  end
end
