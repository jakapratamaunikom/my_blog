require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success for published_ru" do
      @article = FactoryGirl.create(:article, published_ru: true, published_en: false)
      get :show, id: @article.id
      expect(response).to have_http_status(:success)
    end

    it "returns http success for published_en" do
      @article = FactoryGirl.create(:article, published_ru: false, published_en: true)
      get :show, id: @article.id
      expect(response).to have_http_status(:success)
    end

    it "returns not found for unplished article" do
      @article = FactoryGirl.create(:article, published_ru: false, published_en: false)
      expect do
        get :show, id: @article.id
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end


  describe "GET #preview" do
    it "returns http success for published_ru" do
      @article = FactoryGirl.create(:article, published_ru: true, published_en: false)
      get :preview, id: @article.id
      expect(response).to have_http_status(:success)
    end

    it "returns http success for published_en" do
      @article = FactoryGirl.create(:article, published_ru: false, published_en: true)
      get :preview, id: @article.id
      expect(response).to have_http_status(:success)

    end
    it "returns http success for unplished" do
      @article = FactoryGirl.create(:article, published_ru: false, published_en: false)
      get :preview, id: @article.id
      expect(response).to have_http_status(:success)
    end
    
  end

end
