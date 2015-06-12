require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do

    it "returns http success for published_ru if current_lang ru" do
      allow(controller).to receive(:current_lang).and_return(:ru)

      @article = FactoryGirl.create(:article)
      @article.get_content(:ru).set_published!
      @article.get_content(:en).set_unpublished!
      get :show, id: @article.id
      expect(response).to have_http_status(:success)
    end

    it "returns http success for published_en if current_lang en" do
      allow(controller).to receive(:current_lang).and_return(:en)
      @article = FactoryGirl.create(:article)
      @article.get_content(:en).set_published!
      @article.get_content(:ru).set_unpublished!

      get :show, id: @article.id
      expect(response).to have_http_status(:success)
    end

    it "returns not found for ru and en languages if unplished article_content" do
      @article = FactoryGirl.create(:article)
      @article.get_content(:ru).set_unpublished!
      @article.get_content(:en).set_unpublished!
      
      allow(controller).to receive(:current_lang).and_return(:ru)
      expect do
        get :show, id: @article.id
      end.to raise_error ActiveRecord::RecordNotFound

      allow(controller).to receive(:current_lang).and_return(:en)
      expect do
        get :show, id: @article.id
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end


  describe "GET #preview" do
    it "returns http success for published_ru" do
      @article = FactoryGirl.create(:article)
      @article.get_content(:ru).set_published!
      @article.get_content(:en).set_unpublished!
      get :preview, id: @article.id
      expect(response).to have_http_status(:success)
    end

    it "returns http success for published_en" do
      @article = FactoryGirl.create(:article)
      @article.get_content(:en).set_published!
      @article.get_content(:ru).set_unpublished!
      get :preview, id: @article.id
      expect(response).to have_http_status(:success)

    end
    it "returns http success for unplished" do
      @article = FactoryGirl.create(:article)
      @article.get_content(:ru).set_unpublished!
      @article.get_content(:en).set_unpublished!
      get :preview, id: @article.id
      expect(response).to have_http_status(:success)
    end
    
  end

end
