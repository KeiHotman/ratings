class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :ratings
  has_many :taken_ratings, -> { where(prediction: false, taken: true) }, class_name: 'Rating'
  has_many :rated_items, through: :taken_ratings, class_name: 'Item', source: 'item'
  has_many :targeted_similarities, class_name: 'UsersSimilarity', foreign_key: 'target_id'
  has_many :rating_details

  enum department: Constants::DEPARTMENTS

  validates :name, presence: true

  def rated_items_in(items)
    self.rated_items.joins(:ratings).merge(Rating.where(item: items)).uniq
  end

  def negative_ratings_cause_digest
    rating_details.includes(:item, :item_detail).map{|rd| [rd.item.name, rd.item_detail.name]}
  end
end
