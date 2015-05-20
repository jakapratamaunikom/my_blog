require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  before(:all) do
    Tag.destroy_all
    @tag1 = FactoryGirl.create(:tag)
    @tag2 = FactoryGirl.create(:tag)
  end

  describe "PUT #mark" do
    it 'redirect to articles_path' do
      put :mark, id: @tag1.id
      expect(response).to redirect_to(articles_path)
    end

    it "save tag_id to session" do
      put :mark, id: @tag1.id
      expect(session[:tag_ids]).to eq([@tag1.id])
    end

    it 'remove tag_id from session if tag_id is exist' do
      session[:tag_ids] = [@tag1.id]
      put :mark, id: @tag1.id
      expect(session[:tag_ids]).to eq([])
    end

  end


end
