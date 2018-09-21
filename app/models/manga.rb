class Manga < ApplicationRecord
  has_one :anime
  has_many :comments, dependent: :destroy
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
  enum status: {not_finished: 0, finished: 1}

  scope :order_manga, -> {order created_at: :desc}
  scope :most_view, -> {order number_of_read: :desc}
  scope :top_rate, -> {includes(:rate_average_without_dimension).order("rating_caches.avg desc")}
  scope :most_followed, -> {joins(:followers).group("mangas.id").order("count(*) desc")}
  ratyrate_rateable "rate_manga", "rate_chapter"
  acts_as_votable
  acts_as_paranoid

  extend FriendlyId
  friendly_id :name, use: :slugged

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

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
