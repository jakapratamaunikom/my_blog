require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :controller do

  let(:valid_attributes) {
    valid_product_type = FactoryGirl.build(:article)
    valid_product_type.attributes.except('id', 'created_at', 'updated_at')
  }

  let(:invalid_attributes) {
    {'title_ru' => nil, 'title_en' => nil}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    before(:each) do
      Article.destroy_all
    end
    
    it "assigns all articles as @articles" do
      article = FactoryGirl.create(:article)
      get :index, {}, valid_session
      expect(assigns(:articles)).to eq([article])
    end
  end

  describe "GET #show" do
    it "assigns the requested article as @article" do
      article = FactoryGirl.create(:article)
      get :show, {:id => article.to_param}, valid_session
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "GET #new" do
    it "assigns a new article as @article" do
      get :new, {}, valid_session
      expect(assigns(:article)).to be_a_new(Article)
    end
  end

  describe "GET #edit" do
    it "assigns the requested article as @article" do
      article = FactoryGirl.create(:article)
      get :edit, {:id => article.to_param}, valid_session
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Article" do
        expect {
          post :create, {:article => valid_attributes}, valid_session
        }.to change(Article, :count).by(1)
      end

      it "assigns a newly created article as @article" do
        post :create, {:article => valid_attributes}, valid_session
        expect(assigns(:article)).to be_a(Article)
        expect(assigns(:article)).to be_persisted
      end

      it "redirects to the created article" do
        post :create, {:article => valid_attributes}, valid_session
        expect(response).to redirect_to([:admin, Article.last])
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved article as @article" do
        post :create, {:article => invalid_attributes}, valid_session
        expect(assigns(:article)).to be_a_new(Article)
      end

      it "re-renders the 'new' template" do
        post :create, {:article => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        valid_attributes
      }

      it "updates the requested article" do
        article = FactoryGirl.create(:article)
        put :update, {:id => article.to_param, :article => new_attributes}, valid_session
        article.reload
      end

      it "assigns the requested article as @article" do
        article = FactoryGirl.create(:article)
        put :update, {:id => article.to_param, :article => valid_attributes}, valid_session
        expect(assigns(:article)).to eq(article)
      end

      it "redirects to the article" do
        article = FactoryGirl.create(:article)
        put :update, {:id => article.to_param, :article => valid_attributes}, valid_session
        expect(response).to redirect_to([:admin, article])
      end
    end

    context "with invalid params" do
      it "assigns the article as @article" do
        article = FactoryGirl.create(:article)
        put :update, {:id => article.to_param, :article => invalid_attributes}, valid_session
        expect(assigns(:article)).to eq(article)
      end

      it "re-renders the 'edit' template" do
        article = FactoryGirl.create(:article)
        put :update, {:id => article.to_param, :article => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested article" do
      article = FactoryGirl.create(:article)
      expect {
        delete :destroy, {:id => article.to_param}, valid_session
      }.to change(Article, :count).by(-1)
    end

    it "redirects to the articles list" do
      article = FactoryGirl.create(:article)
      delete :destroy, {:id => article.to_param}, valid_session
      expect(response).to redirect_to(admin_articles_url)
    end
  end

end
