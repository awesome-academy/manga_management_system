class Chapter < ApplicationRecord
  belongs_to :manga

  delegate :category, :to => :manga
end
