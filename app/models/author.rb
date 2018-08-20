class Author < ApplicationRecord
  has_many :composes
  has_many :mangas, through: :composes
end
