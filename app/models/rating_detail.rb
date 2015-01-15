class RatingDetail < ActiveRecord::Base
  belongs_to :rating
  belongs_to :item
  belongs_to :item_detail
end
