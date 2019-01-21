require 'rails_helper'

RSpec.describe Picture, type: :model do
  context 'validations' do
    # it { is_expected.to validate_presence_of :image }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_presence_of :model }
    it { is_expected.to validate_presence_of :title }
    # it { is_expected.to validate_length_of(:description).is_at_most(1000) }
    # it { is_expected.to validate_length_of(:title).is_at_most(140) }
    # it { is_expected.to validate_length_of(:price).is_at_most(4) }
    it { is_expected.to validate_length_of(:description).is_at_least(3).is_at_most(1000) }
    it { is_expected.to validate_length_of(:title).is_at_least(3).is_at_most(15) }
  end
  context 'assocations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :line_items }
  end
end
