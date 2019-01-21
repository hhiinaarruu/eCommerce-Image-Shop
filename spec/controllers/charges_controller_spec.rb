require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:carts) { create_list(:cart, 5) }

  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }


  before { sign_in user }

  describe '#index' do
    def do_request
      get :index
    end
    it "index" do
      do_request
      expect(response).to render_template :index
    end
  end

  describe '#create' do
    def do_request
      post :create, charges_params
    end

    context 'no customer' do
      let!(:picture) { create(:picture, price: 500) }
      let!(:cart3) { create(:cart, user: user) }
      let!(:line_item) { create(:line_item, picture: picture, cart: cart3) }
      let(:charges_params) { { cart_id: cart3.id } }

      before do
        session[:cart_id] = cart3.id
        do_request
      end

      it 'create new picture' do
        expect(response).to redirect_to :new_charge
      end
    end

    context 'customer' do
      let(:customer) {
        Stripe::Customer.create({
          email: 'johnny@appleseed.com',
          source: stripe_helper.generate_card_token,
        })
      }
      let!(:picture) { create(:picture, price: 500) }
      let!(:cart3) { create(:cart, user: user) }
      let!(:line_item) { create(:line_item, picture: picture, cart: cart3) }
      let(:charges_params) { { stripeEmail: 'johnny@appleseed.com', stripeToken: customer.id, cart_id: cart3.id } }

      before do
        user.update(stripe_token: customer.id)
        session[:cart_id] = cart3.id
        do_request
      end

      it 'create new picture' do
        expect(response).to redirect_to :new_charge
      end
    end
  end
end
