class RatingDetail < ActiveRecord::Base
  belongs_to :rating
  belongs_to :user
  belongs_to :item
  belongs_to :item_detail

  scope :between, -> (item, user) {
    where(item: item, user: user).includes(:item_detail)
  }
end
