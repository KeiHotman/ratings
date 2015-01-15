FactoryGirl.define do
  factory :item_detail do
    sequence(:name){|n| "ItemDetail#{n}"}

    factory :invalid_item_detail do
      name nil
    end
  end
end
