class Chapter < ApplicationRecord
  belongs_to :manga
  has_many :comments

  delegate :category, :to => :manga
end
