require 'rails_helper'

RSpec.describe WorksController, type: :controller do
  include Devise::TestHelpers
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success for published_ru" do
      @work = FactoryGirl.create(:work)
      allow(controller).to receive(:current_lang).and_return(:ru)
      @work.get_content(:ru).set_published!
      @work.get_content(:en).set_unpublished!
      
      get :show, id: @work.id
      expect(response).to have_http_status(:success)
    end

    it "returns http success for published_en" do
      @work = FactoryGirl.create(:work)
      allow(controller).to receive(:current_lang).and_return(:en)
      @work.get_content(:en).set_published!
      @work.get_content(:ru).set_unpublished!

      get :show, id: @work.id
      expect(response).to have_http_status(:success)
    end

    it "returns not found for unplished work" do
      @work = FactoryGirl.create(:work)
      @work.get_content(:ru).set_unpublished!
      @work.get_content(:en).set_unpublished!
      
      expect do
        get :show, id: @work.id
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end


  describe "GET #preview" do
    it "returns http success for published_ru" do
      @work = FactoryGirl.create(:work)
      @work.get_content(:ru).set_published!
      @work.get_content(:en).set_unpublished!
      
      get :preview, id: @work.id
      expect(response).to have_http_status(:success)
    end

    it "returns http success for published_en" do
      @work = FactoryGirl.create(:work)
      @work.get_content(:en).set_published!
      @work.get_content(:ru).set_unpublished!
      
      get :preview, id: @work.id
      expect(response).to have_http_status(:success)

    end
    it "returns http success for unplished" do
      @work = FactoryGirl.create(:work)
      @work.get_content(:ru).set_unpublished!
      @work.get_content(:en).set_unpublished!
      
      get :preview, id: @work.id
      expect(response).to have_http_status(:success)
    end
    
  end

end
