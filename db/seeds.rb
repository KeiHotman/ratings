Item.delete_all
User.delete_all
Rating.delete_all
UsersSimilarity.delete_all

def create_ratings_with(scores, items, user)
  scores.each_with_index do |score, i|
    FactoryGirl.create(:rating, score: score, item: items[i], user: user)
  end
end

ActiveRecord::Base.transaction do
  5.times { FactoryGirl.create(:item_detail) }
  @items = Array.new(5){ FactoryGirl.create(:item) }
  @users = Array.new(4){ FactoryGirl.create(:user) }
  alice = FactoryGirl.create(:user, name: 'Alice')
  @users.unshift(alice)
end

ratings_data = [
  { user: @users[0], scores: [5, 3, 4, 4] },
  { user: @users[1], scores: [3, 1, 2, 3, 3] },
  { user: @users[2], scores: [4, 3, 4, 3, 5] },
  { user: @users[3], scores: [3, 3, 1, 5, 4] },
  { user: @users[4], scores: [1, 5, 5, 2, 1] },
]

ratings_data.each do |data|
  create_ratings_with data[:scores], @items, data[:user]
end
