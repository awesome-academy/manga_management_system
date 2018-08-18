class Manga < ApplicationRecord
  has_one :anime
  has_many :rates
  has_many :comments
  has_many :likes
  has_many :follows
  has_many :chapters
  has_many :composes
  belongs_to :category

  scope :desc, -> {
    order updated_at: :desc
  }
end
