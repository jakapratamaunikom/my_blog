require 'rails_helper'

RSpec.describe Admin::TagsController, type: :controller do 

  let(:valid_attributes) {
    valid_product_type = FactoryGirl.build(:tag)
    valid_product_type.attributes.except('id', 'created_at', 'updated_at')
  }

  let(:invalid_attributes) {
    {'title' => nil, 'lang' => nil}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    before(:each) do
      Tag.destroy_all
    end
    
    it "assigns all tags as @tags" do
      tag = FactoryGirl.create(:tag)
      get :index, {}, valid_session
      expect(assigns(:tags)).to eq([tag])
    end
  end

  describe "GET #new" do
    it "assigns a new tag as @tag" do
      get :new, {}, valid_session
      expect(assigns(:tag)).to be_a_new(Tag)
    end
  end

  describe "GET #edit" do
    it "assigns the requested tag as @tag" do
      tag = FactoryGirl.create(:tag)
      get :edit, {:id => tag.to_param}, valid_session
      expect(assigns(:tag)).to eq(tag)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Tag" do
        expect {
          post :create, {:tag => valid_attributes}, valid_session
        }.to change(Tag, :count).by(1)
      end

      it "assigns a newly created tag as @tag" do
        post :create, {:tag => valid_attributes}, valid_session
        expect(assigns(:tag)).to be_a(Tag)
        expect(assigns(:tag)).to be_persisted
      end

      it "redirects to the admin_tags" do
        post :create, {:tag => valid_attributes}, valid_session
        expect(response).to redirect_to(admin_tags_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved tag as @tag" do
        post :create, {:tag => invalid_attributes}, valid_session
        expect(assigns(:tag)).to be_a_new(Tag)
      end

      it "re-renders the 'new' template" do
        post :create, {:tag => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end


  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        valid_attributes
      }

      it "updates the requested tag" do
        tag = FactoryGirl.create(:tag)
        put :update, {:id => tag.to_param, :tag => new_attributes}, valid_session
        tag.reload
      end

      it "assigns the requested tag as @tag" do
        tag = FactoryGirl.create(:tag)
        put :update, {:id => tag.to_param, :tag => valid_attributes}, valid_session
        expect(assigns(:tag)).to eq(tag)
      end

      it "redirects to admin_tags" do
        tag = FactoryGirl.create(:tag)
        put :update, {:id => tag.to_param, :tag => valid_attributes}, valid_session
        expect(response).to redirect_to(admin_tags_path)
      end
    end

    context "with invalid params" do
      it "assigns the tag as @tag" do
        tag = FactoryGirl.create(:tag)
        put :update, {:id => tag.to_param, :tag => invalid_attributes}, valid_session
        expect(assigns(:tag)).to eq(tag)
      end

      it "re-renders the 'edit' template" do
        tag = FactoryGirl.create(:tag)
        put :update, {:id => tag.to_param, :tag => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end


end