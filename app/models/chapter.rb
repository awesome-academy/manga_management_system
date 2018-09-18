class Chapter < ApplicationRecord
  belongs_to :manga
  has_many :pages
  accepts_nested_attributes_for :pages
  acts_as_votable

  mount_uploader :images, ThumbnailUploader

  scope :next_chapter, -> (id){
    where("id > ?", id).order(id: :asc)
  }

  scope :previous_chapter, -> (id){
    where("id < ?", id).order(id: :desc)
  }
end
