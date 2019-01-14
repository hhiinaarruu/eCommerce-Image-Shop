require 'rails_helper'

RSpec.describe LineItem, type: :model do
  context 'assocations' do
    it { is_expected.to belong_to :picture }
    it { is_expected.to belong_to :cart }
  end
end
