require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:valid_attributes) {
    valid_product_type = FactoryGirl.build(:comment)
    valid_product_type.attributes.except('id', 'created_at', 'updated_at')
  }

  let(:invalid_attributes) {
    {'title_ru' => nil, 'title_en' => nil}
  }

  let(:valid_session) { {} }


  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, {:comment => valid_attributes, format: 'js'}, valid_session
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, {:comment => valid_attributes, format: 'js'}, valid_session
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end
    end
  end

end
