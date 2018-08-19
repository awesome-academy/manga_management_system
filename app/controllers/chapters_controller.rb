class ChaptersController < ApplicationController
  before_action :get_chapter, only: [:show]

  def show
    @chapters = @chapter.manga.chapters.all
  end

  private
  def get_chapter
    @chapter = Chapter.find_by id: params[:id]
    if @chapter.nil?
      redirect_to root_url
    end
  end
end
