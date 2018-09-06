class Rate < ActiveRecord::Base
  belongs_to :rater, class_name: "User"
  belongs_to :rateable, polymorphic: true

  #attr_accessible :rate, :dimension
  scope :rateable, ->{where(rateable_id: ids, rateable_type: 'manga')}
  scope :dimensions, ->{where(dimension: "rate_manga")}
end
