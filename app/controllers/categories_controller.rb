class CategoriesController < ApplicationController
  before_action :get_category, only: [:show]

  def index
    @categories = Category.order(:name)
  end

  def show
    @mangas = @category.mangas.order(:name)
  end

  private
  def get_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      redirect_to root_url
    end
  end
end
