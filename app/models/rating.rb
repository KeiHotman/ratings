class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  scope :good_prediction_for, -> (user) {
    where(user: user, prediction: true).where("score >= 4").includes(:item)
  }
end
