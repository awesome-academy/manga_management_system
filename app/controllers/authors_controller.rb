class AuthorsController < ApplicationController
  before_action :get_author, only: [:show]

  def show
    @mangas = @author.mangas.all
  end

  private
  def get_author
    @author = Author.find_by id: params[:id]
    if @author.nil?
      redirect_to root_url
    end
  end
end
