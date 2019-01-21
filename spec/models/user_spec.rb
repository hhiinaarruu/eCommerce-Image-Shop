require 'rails_helper'

RSpec.describe User, type: :model do
  context 'assocations' do
    it { is_expected.to have_many :pictures }
    it { is_expected.to have_many :carts }
  end
end
