require 'rails_helper'

RSpec.describe Admin::WorksController, type: :controller do

  let(:valid_attributes) {
    ru_content = FactoryGirl.build(:work_content)
    en_content = FactoryGirl.build(:work_content)
    first_image  = FactoryGirl.create(:image)
    second_image = FactoryGirl.create(:image)


    params = {
      :ru_title     => ru_content.title,
      :ru_content   => ru_content.content,
      :ru_published => ru_content.published,
      :en_title     => en_content.title,
      :en_content   => en_content.content,
      :en_published => en_content.published,
      :image_ids    => [first_image.id, second_image.id],
    }
  }

  let(:invalid_attributes) {
    {'ru_title' => nil, 'en_title' => nil}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    before(:each) do
      Work.destroy_all
    end
    
    it "assigns all works as @works" do
      work = FactoryGirl.create(:work)
      get :index, {}, valid_session
      expect(assigns(:works)).to eq([work])
    end
  end

  describe "GET #show" do
    it "assigns the requested work as @work" do
      work = FactoryGirl.create(:work)
      get :show, {:id => work.to_param}, valid_session
      expect(assigns(:work)).to eq(work)
    end
  end

  describe "GET #new" do
    it "assigns a new work as @work" do
      get :new, {}, valid_session
      expect(assigns(:work)).to be_a_new(Work)
    end
  end

  describe "GET #edit" do
    it "assigns the requested work as @work" do
      work = FactoryGirl.create(:work)
      get :edit, {:id => work.to_param}, valid_session
      expect(assigns(:work)).to eq(work)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Work" do
        work_attributes = valid_attributes
        expect {
          post :create, {:work => work_attributes}, valid_session
        }.to change(Work, :count).by(1)
      end

      it "assigns a newly created work as @work" do
        post :create, {:work => valid_attributes}, valid_session
        expect(assigns(:work)).to be_a(Work)
        expect(assigns(:work)).to be_persisted
      end

      it "redirects to the created work" do
        post :create, {:work => valid_attributes}, valid_session
        expect(response).to redirect_to([:admin, Work.first])
      end

      it 'create references between images' do
        post :create, {:work => valid_attributes}, valid_session
        expect(Work.first.images.count).to eq(2)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved work as @work" do
        post :create, {:work => invalid_attributes}, valid_session
        expect(assigns(:work)).to be_a_new(Work)
      end

      it "re-renders the 'new' template" do
        post :create, {:work => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        valid_attributes
      }

      it "updates the requested work" do
        work = FactoryGirl.create(:work)
        put :update, {:id => work.to_param, :work => new_attributes}, valid_session
        work.reload
      end

      it "assigns the requested work as @work" do
        work = FactoryGirl.create(:work)
        put :update, {:id => work.to_param, :work => valid_attributes}, valid_session
        expect(assigns(:work)).to eq(work)
      end

      it "redirects to the work with default language ru" do
        work = FactoryGirl.create(:work)
        put :update, {:id => work.to_param, :work => valid_attributes}, valid_session
        expect(response).to redirect_to(admin_work_path(work, lang: :ru))
      end

      it "redirects to the work with language en if lang = en" do
        work = FactoryGirl.create(:work)
        put :update, {:id => work.to_param, :work => valid_attributes, lang: :en}, valid_session
        expect(response).to redirect_to(admin_work_path(work, lang: :en))
      end
    end

    context "with invalid params" do
      it "assigns the work as @work" do
        work = FactoryGirl.create(:work)
        put :update, {:id => work.to_param, :work => invalid_attributes}, valid_session
        expect(assigns(:work)).to eq(work)
      end

      it "re-renders the 'edit' template" do
        work = FactoryGirl.create(:work)
        put :update, {:id => work.to_param, :work => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested work" do
      work = FactoryGirl.create(:work)
      expect {
        delete :destroy, {:id => work.to_param}, valid_session
      }.to change(Work, :count).by(-1)
    end

    it "redirects to the works list" do
      work = FactoryGirl.create(:work)
      delete :destroy, {:id => work.to_param}, valid_session
      expect(response).to redirect_to(admin_works_url)
    end

    it "set removed field to true" do
      work = FactoryGirl.create(:work)
      expect(work.removed).to eq(false)
      delete :destroy, {:id => work.to_param}, valid_session
      work.reload
      expect(work.removed).to eq(true)
    end

  end

  describe "PUT toggle_published_status" do
    before(:each) do
      request.env["HTTP_REFERER"] = admin_works_url
    end

    it 'change published_status for language to opposite of current' do
      work = FactoryGirl.create(:work)
      work.russian_content.update_column :published, true
      work.english_content.update_column :published, false
      put :toggle_published_status, {id: work.id, lang: :ru}, valid_session
      work.reload
      expect(work.russian_content.published?).to eq(false)
      expect(work.english_content.published?).to eq(false)

      put :toggle_published_status, {id: work.id, lang: :en}, valid_session
      work.reload
      expect(work.russian_content.published?).to eq(false)
      expect(work.english_content.published?).to eq(true)
    end
  end

end
