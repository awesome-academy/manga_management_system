class SearchesController < ApplicationController
  def index
    q = params[:search]
    mangas = Manga.search(name_cont: q).result
  end
end
