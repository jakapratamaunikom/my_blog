require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  let(:valid_attributes) {
    {}
  }

  let(:invalid_attributes) {
    {}
  }

  let(:valid_session) { {} }

  describe "GET #about_me" do
    it "successful action" do
      get :about_me, {}, valid_session
    end
  end

  
end
