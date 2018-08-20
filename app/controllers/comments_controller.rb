class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  before_action :get_chapter, only: [:create]

  def index
    # created in order to handle renders from this controller, which produce URL 'root/chapters/:id/comments'
    chapter = Chapter.find_by id: params[:id]
    redirect_to chapter
  end

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
    respond_to do |format|
     format.js { render action: "new" }
    end
  end

  def create
    redirect_to @chapter if @comment.author = User.select("name")
    if params[:comment][:parent_id].to_i > 0
      parent = @chapter.comments.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_params)
    else
      @comment = @chapter.comments.build(comment_params)
    end
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = t("comment_created")
          redirect_to @chapter
        end
        format.js
      end
    else
      respond_to do |format|
        format.html { render @chapter }
        format.js { render action: 'failed_save' }
      end
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    @chapter = @comment.chapter
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:success] = t("comment_deleted")
        redirect_to @chapter
      end
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:author, :content, :chapter_id, :parent_id)
  end

  def get_chapter
    @chapter = Chapter.find_by id: params[:comment][:chapter_id]
    if @chapter.nil?
      redirect_to root_url
    end
  end
end
