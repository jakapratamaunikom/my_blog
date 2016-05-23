require 'rails_helper'

RSpec.describe Admin::NotesController, type: :controller do

  let(:valid_attributes) {
    {'title' => 'test_title', 'description' => 'test_description'}
  }

  let(:invalid_attributes) {
    {'title' => nil, 'description' => nil}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    before(:each) do
      Note.destroy_all
      @note = FactoryGirl.create(:note)
    end
    
    it "assigns all notes as @notes" do
      get :index, {}, valid_session
      expect(assigns(:notes)).to eq([@note])
    end

    it 'redirect to sessions#new if current user not admin' do
      allow(controller).to receive(:current_user_admin?).and_return(false)
      get :index, {}, valid_session
      expect(response).to redirect_to admin_sign_in_path(back_url: admin_notes_url)
    end
  end

  describe "GET #show" do
    it "assigns the requested note as @note" do
      note = FactoryGirl.create(:note)
      get :show, {:id => note.to_param}, valid_session
      expect(assigns(:note)).to eq(note)
    end
  end

  describe "GET #new" do
    it "assigns a new note as @note" do
      get :new, {}, valid_session
      expect(assigns(:note)).to be_a_new(Note)
    end
  end

  describe "GET #edit" do
    it "assigns the requested note as @note" do
      note = FactoryGirl.create(:note)
      get :edit, {:id => note.to_param}, valid_session
      expect(assigns(:note)).to eq(note)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Note" do
        note_attributes = valid_attributes
        expect {
          post :create, {:note => note_attributes}, valid_session
        }.to change(Note, :count).by(1)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved note as @note" do
        post :create, {:note => invalid_attributes}, valid_session
        expect(assigns(:note)).to be_a_new(Note)
      end

      it "re-renders the 'new' template" do
        post :create, {:note => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {'title' => 'new_test_title', 'description' => 'new_test_description'}
      }

      it "updates the requested note" do
        note = FactoryGirl.create(:note)
        put :update, {:id => note.to_param, :note => new_attributes}, valid_session
        note.reload
      end

      it "assigns the requested note as @note" do
        note = FactoryGirl.create(:note)
        put :update, {:id => note.to_param, :note => valid_attributes}, valid_session
        expect(assigns(:note)).to eq(note)
      end
    end

    context "with invalid params" do
      it "assigns the note as @note" do
        note = FactoryGirl.create(:note)
        put :update, {:id => note.to_param, :note => invalid_attributes}, valid_session
        expect(assigns(:note)).to eq(note)
      end

      it "re-renders the 'edit' template" do
        note = FactoryGirl.create(:note)
        put :update, {:id => note.to_param, :note => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested note" do
      note = FactoryGirl.create(:note)
      expect {
        delete :destroy, {:id => note.to_param}, valid_session
      }.to change(Note, :count).by(-1)
    end

    it "redirects to the notes list" do
      note = FactoryGirl.create(:note)
      delete :destroy, {:id => note.to_param}, valid_session
      expect(response).to redirect_to(admin_notes_url)
    end
  end
end
