class User < ActiveRecord::Base
  has_many :ratings
  has_many :rated_items, through: :ratings, class_name: 'Item', source: 'item'
  has_many :targeted_similarities, class_name: 'UsersSimilarity', foreign_key: 'target_id'

  enum department: Constants::DEPARTMENTS

  validates :name, presence: true

  def rated_items_in(items)
    self.rated_items.joins(:ratings).merge(Rating.where(item: items)).uniq
  end
end
