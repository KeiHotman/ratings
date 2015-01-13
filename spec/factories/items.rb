FactoryGirl.define do
  factory :item do
    sequence(:name){|n| "Item#{n}" }
    grade 1
    department 1
    factory :invalid_item do
      name ''
    end
  end
end
