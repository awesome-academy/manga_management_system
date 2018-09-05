class RatesController < ApplicationController
  before_action :get_rate, only: [:show, :edit, :update, :destroy]
  before_action :find_manga
  before_action :authenticate_user!

  def new
    @rate = Rate.new
  end

  def edit
  end

  def create
    @rate = Rate.new rate_params
    @rate.user_id = current_user.id
    @rate.manga_id = @manga.id

    if @rate.save
      redirect_to @manga
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @rate.update rate_params
        format.html { redirect_to @manga, notice: t("rate_updated") }
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html { render :edit }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rate.destroy
    respond_to do |format|
      format.html { redirect_to rates_url, notice: t("rate_destroy") }
      format.json { head :no_content }
    end
  end

  private

  def get_rate
    @rate = Rate.find_by id: params[:id]
    redirect_to manga_path unless @rate
  end

  def find_manga
    @manga = Manga.find_by id: params[:manga_id]
    redirect_to manga_path unless @manga
  end

  def rate_params
    params.require(:rate).permit(:rating)
  end
end
