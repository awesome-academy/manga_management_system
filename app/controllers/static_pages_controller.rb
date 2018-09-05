class StaticPagesController < ApplicationController
  before_action :show_categories

  def home
    @mangas = Manga.all.limit(Settings.mangas.limit).sort{|a| a.followers.count}.reverse
    @slider = Manga.order("RAND()").limit(Settings.mangas.limit)
    @fmangas = Manga.all.limit(Settings.mangas.limit)
    @mvmangas = Manga.most_view.limit(Settings.mangas.limit)
    @trmangas = Manga.top_rate.limit(Settings.mangas.limit)
    @nmangas = Manga.order_manga.limit(Settings.mangas.limit)
  end

  def contact
  end

  private
  def show_categories
    @categories = Category.all
  end
end
