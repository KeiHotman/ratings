class ItemDetail < ActiveRecord::Base
  validates :name, presence: true

  scope :id_not_in, -> (item_detail_ids) {
    item_detail_ids.present? ? where("id not in (?)", item_detail_ids) : all
  }
end
