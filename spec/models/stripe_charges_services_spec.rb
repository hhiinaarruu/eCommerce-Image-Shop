require 'rails_helper'

RSpec.describe StripeChargesServices, type: :model do
  let!(:user) { create(:user, stripe_token: nil) }
  let!(:cart) { create(:cart, user: user) }
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  # it { is_expect(response.status).to eq(200) }
  # describe "#create_customer" do
  #   it "create_customer" do
  #     customer = Stripe::Customer.create({
  #       email: 'johnny@appleseed.com',
  #       source: stripe_helper.generate_card_token
  #     })
  #     user.update(stripe_token: customer.id)

  #   end
  # end

end
