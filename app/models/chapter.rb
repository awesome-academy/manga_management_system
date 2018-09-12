class Chapter < ApplicationRecord
  belongs_to :manga
  acts_as_votable

  mount_uploader :images, ThumbnailUploader

  after_create_commit {create_chapter_noti}

  scope :next_chapter, -> (id){
    where("id > ?", id).order(id: :asc)
  }

  scope :previous_chapter, -> (id){
    where("id < ?", id).order(id: :desc)
  }

  def create_chapter_noti
    @c = Chapter.last
    @manga = @c.manga
    if @manga.followers.ids include? current_user.id
      Event.create message: "a new chapter in {@manga.name} was created"
    end
  end
end
