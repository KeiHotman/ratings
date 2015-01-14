Item.delete_all
User.delete_all
Rating.delete_all
UsersSimilarity.delete_all

5.times do
  FactoryGirl.create(:item)
end

items = Item.limit(5)
alice = FactoryGirl.create(:user, name: 'Alice')

[5,3,4,4].each_with_index do |score, index|
  FactoryGirl.create(:rating, score: score, item: items[index], user: alice)
end

u1 = FactoryGirl.create(:user)
[3,1,2,3,3].each_with_index do |score, index|
  FactoryGirl.create(:rating, score: score, item: items[index], user: u1)
end

u2 = FactoryGirl.create(:user)
[4, 3, 4, 3, 5].each_with_index do |score, index|
  FactoryGirl.create(:rating, score: score, item: items[index], user: u2)
end

u3 = FactoryGirl.create(:user)
[3, 3, 1, 5, 4].each_with_index do |score, index|
  FactoryGirl.create(:rating, score: score, item: items[index], user: u3)
end

u4 = FactoryGirl.create(:user)
[1, 5, 5, 2, 1].each_with_index do |score, index|
  FactoryGirl.create(:rating, score: score, item: items[index], user: u4)
end
