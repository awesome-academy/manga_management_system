class Page < ApplicationRecord
  belongs_to :chapter
  mount_uploader :image, ThumbnailUploader
end
