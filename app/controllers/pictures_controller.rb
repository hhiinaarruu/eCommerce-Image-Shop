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
<<<<<<< d346684797ca53993495499141327d92c8908ecb
    @pictures = if params[:search].blank?
                    Picture.filter(params.slice(:author, :finish, :condition))
                  else
                    Picture.search(params)
                  end
=======
    @pictures = if  params[:search].blank?
                  Picture.filter(params.slice(:author, :finish, :condition))
                else
                  Picture.search(params)
                end
>>>>>>> final-project
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    @user = User.all
    respond_to do |format|
      if @picture.save
        @user.each do |user|
          format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
          format.json { render :show, status: :created, location: @picture }
          PictureNotifierMailer.send_picture_notifier_email(user).deliver
        end
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
