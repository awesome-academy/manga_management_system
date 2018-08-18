class Admin::CategoriesController < Admin::AdminController
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.categories.page
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:info] = t"category_created"
      redirect_to admin_categories_path
    else
      flash[:alert] = t"category_creating_error"
      render :index
    end
  end
  def edit;end

  def update
    if @category.update category_params
      flash[:alert] = t"category_updated"
      redirect_to admin_categories_path
    else
      flash[:alert] = t"category_updating_error"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t(".categories_deleted")
      redirect_to admin_categories_path
    else
      flash[:success] = t(".categories_not_deleted")
      render :index
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find_by id: params[:id]
    redirect_to admin_categories_path if @category.nil?
  end
end
