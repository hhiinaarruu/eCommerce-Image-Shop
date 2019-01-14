class LineItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_line_item, only: %i[show edit update destroy]
  before_action :set_cart, only: %i[create]

  def index
  end

  def show
  end

  def edit
  end

  def create
    picture = Picture.find(params[:picture_id])
    @line_item = @cart.add_picture(picture)
    if @line_item.save
      redirect_to @line_item.cart, notice: 'Item added to cart.'
    else
      render :new
    end
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @line_item.destroy
    redirect_to cart_path(@cart), notice: 'Item was successfully removed.'
  end

  private

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end
end
