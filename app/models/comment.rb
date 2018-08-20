class Comment < ApplicationRecord
  belongs_to :chapter
  acts_as_tree order: "created_at desc"

  validates :content, presence: true
  validates :author, presence: true

  scope :load_order, -> {
    order created_at: :asc
  }

end
