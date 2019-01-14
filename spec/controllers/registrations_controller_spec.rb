require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let!(:user) { create(:user) }
  before do
    sign_in user
  end

end
