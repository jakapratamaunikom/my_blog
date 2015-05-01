require 'rails_helper'

RSpec.describe Admin::SettingsController, type: :controller do

  let(:valid_attributes) {
    {}
  }

  let(:invalid_attributes) {
    {}
  }

  let(:valid_session) { {} }

  describe "GET #portfolio" do
    it "successfull page" do
      get :portfolio, {}, valid_session
    end
  end

  
end
