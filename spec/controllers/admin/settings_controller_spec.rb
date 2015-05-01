require 'rails_helper'

RSpec.describe Admin::SettingsController, type: :controller do

  let(:valid_attributes) {
    {}
  }

  let(:invalid_attributes) {
    {}
  }

  let(:valid_session) { {} }

  describe "GET #about_me" do
    it "assigns all articles as @articles" do
      get :about_me, {}, valid_session
    end
  end

  describe "GET #portfolio" do
    it "assigns the requested article as @article" do
      get :portfolio, {}, valid_session
    end
  end

  
end
