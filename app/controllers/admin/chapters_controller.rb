class Admin::ChaptersController < Admin::AdminController
  before_action :find_chapter, only: [:edit, :update, :show, :destroy]
  load_and_authorize_resource

  def index
    @chapters = Chapter.paginate page: params[:page], per_page: Settings.chapters.page
  end
  def show
  end

  def new
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new chapter_params
    if @chapter.save
      flash[:info] = t("chapter_created")
      redirect_to admin_chapters_path
    else
      flash[:alert] = t("chapter_creating_error")
      render :new
    end
  end

  def edit
  end

  def update
    if @chapter.update chapter_params
      flash[:alert] = t("chapter_updated")
      redirect_to admin_chapters_path
    else
      flash[:alert] = t("chapter_creating_error")
      render :edit
    end
  end

  def destroy
    if @chapter.destroy
      flash[:success] = t(".chapters_deleted")
      redirect_to admin_chapters_path
    else
      flash[:danger] = t(".chapters_not_deleted")
      render :index
    end
  end

  private

  def chapter_params
    params.require(:chapter).permit(:id, :images, :images_cache, :manga_id, :content)
  end

  def find_chapter
    @chapter = Chapter.find_by id: params[:id]
    redirect_to admin_chapters_path if @chapter.nil?
  end
end
