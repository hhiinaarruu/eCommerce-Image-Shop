require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:cart) { create(:cart, user: user) }


  before do
    sign_in user
    session[:cart_id] = cart.id
  end

  describe '#destroy' do
    def do_request
      delete :destroy, params: {  id: session[:cart_id] }
    end
    it 'destroy cart' do
      expect{ do_request }.to change { Cart.count }.from(1).to(0)
    end
  end
end

    # before { do_request }

