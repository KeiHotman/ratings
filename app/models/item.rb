class Item < ActiveRecord::Base
  enum department: Constants::DEPARTMENTS

  validates :name, presence: true
end
