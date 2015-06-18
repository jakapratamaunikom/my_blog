require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :controller do

  describe 'new' do
    it 'must redirect to root if user authorized' do
      session[:is_admin] = true
      get :new
      expect(response).to redirect_to admin_root_path
    end

    it "must successful render new if user is unathorized" do
      session[:is_admin] = nil
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template("new")
    end

  end

  describe 'check' do
    before(:each) do
      @params = {}
    end

    describe 'successful authorized and' do
      before(:each) do
        @params[:auth] = { password: '112233' }
      end
      
      it 'and redirect_to root if get valid params' do
        post :check, @params
        expect(response).to redirect_to admin_root_path
      end

      it 'and redirect_to back_url if get valid params and back_url params' do
        @params[:auth][:back_url] = 'http://www.manutd.ru/'
        post :check, @params
        expect(response).to redirect_to 'http://www.manutd.ru/'
      end
    end

    it 'access denied and render new if get invalid params' do
      @params[:auth] = {password: 'incorrect'}
      post :check, @params 
      expect(response).to render_template("new")
    end
  end

end
 