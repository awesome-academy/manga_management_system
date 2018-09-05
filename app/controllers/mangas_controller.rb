class MangasController < ApplicationController
  before_action :get_manga, only: [:show]

  def index
    @mangas = Manga.desc.all
  end

  def show
    @chapters = @manga.chapters.all
    @authors = @manga.authors.all
    @categories = @manga.categories.all
    @rates = Rate.rate_manga(@manga.id)

    if @rates.blank?
      @avg_rate = 0
    else
      @avg_rate = @rates.average(:rating).round(Settings.mangas.round)
    end
  end

  private
  def get_manga
    @manga = Manga.find_by id: params[:id]
    if @manga.nil?
      redirect_to root_url
    end
  end
end
