class Item < ActiveRecord::Base
  has_many :ratings
  has_many :rating_details
  has_many :features, class_name: 'ItemFeature'

  enum department: Constants::DEPARTMENTS

  validates :name, presence: true

  accepts_nested_attributes_for :rating_details,
    allow_destroy: true,
    reject_if: proc { |attr| attr['negative_cause'] != '1' }

  accepts_nested_attributes_for :features, allow_destroy: true

  scope :currently_on, -> (user) {
    where(grade: user.grade, department: Constants::DEPARTMENTS[user.department.to_sym])
  }

  scope :refine, -> (grade, department) {
    if grade.present? && department.present?
      where(grade: grade, department: department)
    elsif grade.present?
      where(grade: grade)
    elsif department.present?
      where(department: department)
    else
      all
    end
  }

  def build_rating_details_from_item_details(item_details)
    attrs = item_details.map do |item_detail|
      { item_detail_id: item_detail.id }
    end

    self.rating_details.build(attrs)
  end
end
