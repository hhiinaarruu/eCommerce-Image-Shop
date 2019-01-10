class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    # @pictures = Picture.all.order('created_at desc')
    @pictures = Picture.filter(params.slice(:author, :finish, :condition)).page(params[:page]).per(5)
  end

  def show
  end

  def new
    @picture = current_user.pictures.build
  end

  def edit
  end

  def search
    if params[:search].blank?
      @pictures = Picture.filter(params.slice(:author, :finish, :condition))
    else
      @pictures = Picture.search(params)
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(:author, :model, :description, :condition, :finish, :title, :price, :image)
    end
end
