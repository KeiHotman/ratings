class User < ActiveRecord::Base
  enum department: Constants::DEPARTMENTS

  validates :name, presence: true
end
