require 'rails_helper'


RSpec.describe VAlexL::MyBlog::Authenticator do
  describe 'has method allowed_access?' do
    it 'return false if password incorrect' do
      @authenticator = VAlexL::MyBlog::Authenticator.new 'incorrect'
      expect(@authenticator.allowed_access?).to eq(false)
    end

    it 'return true if password correct and equal 112233' do
      @authenticator = VAlexL::MyBlog::Authenticator.new '112233'
      expect(@authenticator.allowed_access?).to eq(true)
    end
  end

end