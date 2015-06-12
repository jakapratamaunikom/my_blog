require 'rails_helper'

RSpec.describe SettingsController, type: :controller do

  describe "current_lang" do
    it 'will return ru if session[:current_lang] = nil' do
      session[:current_lang] = nil
      expect(controller.current_lang).to eq(:ru)
    end

    it 'will return ru if session[:current_lang] = ru' do
      session[:current_lang] = :ru
      expect(controller.current_lang).to eq(:ru)
    end

    it 'will return en if session[:current_lang] = en' do
      session[:current_lang] = :en
      expect(controller.current_lang).to eq(:en)
    end

  end
  
  describe 'switch_language' do
    it 'will change language from ru to en if session[:current_lang] blank' do
      session[:current_lang] = nil
      put :switch_language
      expect(session[:current_lang]).to eq(:en)
    end

    it 'will change language from ru to en if session[:current_lang]= :ru' do
      session[:current_lang] = :ru
      put :switch_language
      expect(session[:current_lang]).to eq(:en)
    end

    it 'will change language from en to ru' do
      session[:current_lang] = :en
      put :switch_language
      expect(session[:current_lang]).to eq(:ru)
    end
  end

end

