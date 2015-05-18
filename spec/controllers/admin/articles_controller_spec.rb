require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :controller do

  let(:valid_attributes) {
    ru_content = FactoryGirl.build(:article_content)
    en_content = FactoryGirl.build(:article_content)

    params = {
      :ru_title     => ru_content.title,
      :ru_content   => ru_content.content,
      :ru_image     => ru_content.image,
      :ru_published => ru_content.published,
      :en_title     => en_content.title,
      :en_content   => en_content.content,
      :en_image     => en_content.image,
      :en_published => en_content.published,
    }
  }

  let(:invalid_attributes) {
    {'ru_title' => nil, 'en_title' => nil}
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
        article_attributes = valid_attributes
        expect {
          post :create, {:article => article_attributes}, valid_session
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

      it 'create link on tag' do
        ru_tag = FactoryGirl.create(:tag, lang: :ru)
        en_tag = FactoryGirl.create(:tag, lang: :en)
        attributes = valid_attributes.merge ru_tags: [ru_tag.id], en_tags: [en_tag.id]
        post :create, {:article => attributes}, valid_session
        article = assigns(:article)
        expect(article.tag_ids).to eq([ru_tag.id, en_tag.id])

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

      it "redirects to the article with default language ru" do
        article = FactoryGirl.create(:article)
        put :update, {:id => article.to_param, :article => valid_attributes}, valid_session
        expect(response).to redirect_to(admin_article_path(article, lang: :ru))
      end

      it "redirects to the article with language en if lang = en" do
        article = FactoryGirl.create(:article)
        put :update, {:id => article.to_param, :article => valid_attributes, lang: :en}, valid_session
        expect(response).to redirect_to(admin_article_path(article, lang: :en))
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

  describe "PUT toggle_published_status" do
    before(:each) do
      request.env["HTTP_REFERER"] = admin_articles_url
    end

    it 'change published_status for language to opposite of current' do
      article = FactoryGirl.create(:article, published_ru: true, published_en: false)
      put :toggle_published_status, {id: article.id, lang: :ru}, valid_session
      article.reload
      expect(article.published_ru?).to eq(false)
      expect(article.published_en?).to eq(false)

      put :toggle_published_status, {id: article.id, lang: :en}, valid_session
      article.reload
      expect(article.published_ru?).to eq(false)
      expect(article.published_en?).to eq(true)
    end
  end

end
