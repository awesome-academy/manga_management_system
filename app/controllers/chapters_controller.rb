class ChaptersController < ApplicationController
  before_action :get_chapter, only: [:show]

  def show
    @chapters = @chapter.manga.chapters.order("LENGTH(name)").order(:name)
    @previous = @chapters.previous_chapter(@chapter.id).last
    @next = @chapters.next_chapter(@chapter.id).first
  end

  private
  def get_chapter
    @chapter = Chapter.find_by id: params[:id]
    if @chapter.nil?
      redirect_to root_url
    end
  end
end
