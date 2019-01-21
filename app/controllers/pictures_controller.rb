class PicturesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_picture, only: %i[show edit update destroy]
  before_action :set_cart, only: %i[index]
  def index
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
    @pictures = if params[:search].blank?
                  Picture.filter(params.slice(:author, :finish, :condition))
                else
                  Picture.search(params)
                end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    @user = User.all
    if @picture.save
      redirect_to @picture, notice: 'Picture was successfully created.'
      @user.each do |user|
        PictureNotifierMailer.send_picture_notifier_email(user).deliver
      end
    else
      render :new
    end
  end

  def update
    if @picture.update(picture_params)
      redirect_to @picture, notice: 'Picture was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_url, notice: 'Picture was successfully destroyed.'
  end

  private

    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(:author, :model, :description, :condition, :finish, :title, :price, :image)
    end
end
