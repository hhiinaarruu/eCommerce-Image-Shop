class ChargesController < ApplicationController
  before_action :authenticate_user!
  rescue_from Stripe::CardError, with: :catch_exception
  before_action :set_cart, only: %i[create new]

  def new
  end

  def create
    StripeChargesServices.new(charges_params, current_user).call
    CheckoutNotifierMailer.send_checkout_email(current_user).deliver
    @cart.destroy
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
