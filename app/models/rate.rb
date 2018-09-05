class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :manga

  scope :rate_manga, ->(manga_id) {where(manga_id: manga_id)}

end
