module CurrentCart

  def set_cart
    @cart = Cart.find_by_id(session[:cart_id])
    @cart ||= current_user.carts.create
    session[:cart_id] = @cart.id
  end
end
