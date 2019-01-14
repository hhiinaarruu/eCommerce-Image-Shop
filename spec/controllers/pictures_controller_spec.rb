require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:picture) { create(:picture) }

  before do
    sign_in user
  end

  describe "#index" do
    def do_request
      get :index
    end
    let!(:pictures) { create_list(:picture, 5) }
     it 'should return pictures data' do
      do_request
      expect(assigns(:pictures).size).to eq 5
      expect(response).to render_template :index
    end
  end

  describe "#new" do
    def do_request
      get :new
    end
    it 'assigns new user' do
      do_request
      expect(response).to render_template :new
    end
  end

  describe '#destroy' do
    def do_request
      delete :destroy, params: { id: picture.id }
    end
    it 'delete picture' do
      expect{ do_request }.to change { Picture.count }.from(1).to(0)
    end
  end

  describe '#create' do
    context 'success' do
      def do_request
        post :create, params: { picture: picture_params }
      end
      let(:picture_params) { attributes_for( :picture, author: 'HiNaru', model: 'sakuracha',
      description: 'sadaeasdsa', condition: 'New',
      finish: 'Silk', title: 'hah11s', price: 111 ) }
      it 'create new picture' do
        expect{ do_request }.to change { Picture.count }.from(1).to(2)
      end
    end
    context 'fail' do
      def do_request
        post :create, params: { picture: picture_params }
      end
      let(:picture_params) { attributes_for( :picture, title: 'hah11s', price: 111 ) }
      it 'fail create new picture' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#update' do
    context 'success' do
      def do_request
        put :update, params: { id: picture.id, picture: { title: 'asdad' } }
      end
      it 'update picture' do
        do_request
        expect(response.status).to eq(302)
      end
    end
  end
end
