class Manga < ApplicationRecord
  has_one :anime
  has_many :comments
  has_many :likes
  has_many :chapters
  has_many :composes
  has_many :authors, through: :composes
  has_many :manga_categories
  has_many :categories,through: :manga_categories
  has_many :passive_relationships, class_name:  Relationship.name,
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  scope :order_manga, -> {order created_at: :desc}
  scope :most_view, -> {order number_of_read: :desc}
  scope :top_rate, -> {order average_rate: :desc}

  
  ratyrate_rateable "rate_manga","rate_chapter"
  
  mount_uploader :thumbnail, ThumbnailUploader
  mount_uploader :poster, ThumbnailUploader
  
  def overall_ratings(manga)
    array = Rate.rateable
    stars = array.map {|manga| manga.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end

  def avg_rating_dimension_rate_manga(manga)
    array = Rate.rateable.dimensions
    stars = array.map {|manga| manga.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end

end
