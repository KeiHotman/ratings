class Item < ActiveRecord::Base
  has_many :ratings
  has_many :rating_details

  enum department: Constants::DEPARTMENTS

  validates :name, presence: true

  accepts_nested_attributes_for :rating_details, allow_destroy: true, reject_if: proc { |attr| attr['negative_cause'] != '1' }

  def build_rating_details_from_item_details(item_details)
    attrs = item_details.map do |item_detail|
      { item_detail_id: item_detail.id }
    end

    self.rating_details.build(attrs)
  end
end
