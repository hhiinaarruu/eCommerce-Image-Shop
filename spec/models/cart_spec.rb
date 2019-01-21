require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'assocations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :line_items }
  end
end
