class ChargesController < ApplicationController
  before_action :authenticate_user!
  rescue_from Stripe::CardError, with: :catch_exception
  before_action :set_cart, only: %i[create new]

  def index
    @cart_status = current_user.carts
  end

  def show
  end

  def new
  end

  def create
    StripeChargesServices.new(charges_params, current_user).call
    CheckoutNotifierMailer.send_checkout_email(current_user).deliver
    @cart.paid!
    @cart.line_items.each do |litem|
      litem.picture.unavailable!
    end
    session.delete(:cart_id)
    redirect_to new_charge_path
  end

  private

  def charges_params
    params.permit(:stripeEmail, :stripeToken).merge(cart_id: session[:cart_id])
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end
end
