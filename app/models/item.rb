class Item < ActiveRecord::Base
  has_many :ratings

  enum department: Constants::DEPARTMENTS

  validates :name, presence: true
end
