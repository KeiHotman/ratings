class ItemDetail < ActiveRecord::Base
  validates :name, presence: true
end
