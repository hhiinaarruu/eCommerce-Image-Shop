require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:picture) { create(:picture, user: user) }
  let!(:cart) { create(:cart, user: user) }


  before do
    sign_in user
    session[:cart_id] = cart.id
  end

  describe '#destroy' do
    def do_request
      delete :destroy, params: { id: line_item.id }
    end
    let!(:line_item) { create(:line_item , picture: picture, cart: cart) }
    it 'delete picture' do
      expect{ do_request }.to change { LineItem.count }.from(1).to(0)
    end
  end

  describe '#create' do
    context 'success' do
      def do_request
        post :create, params: { picture_id: picture.id }
      end
      it 'create new picture' do
        expect{ do_request }.to change { LineItem.count }.from(0).to(1)
      end
    end
  end
end
