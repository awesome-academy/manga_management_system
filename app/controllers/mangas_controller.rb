class MangasController < ApplicationController
  before_action :get_manga, only: [:show]

  def index
    @mangas = Manga.desc.all
  end

  def show
  end

  private
  def get_manga
    @manga = Manga.find_by id: params[:id]
    if @manga.nil?
      redirect_to root_url
    end
  end
end
