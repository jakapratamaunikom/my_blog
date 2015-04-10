require 'rails_helper'


RSpec.describe VAlexL::MyBlog::FormObjects::Article do
  before(:each) do
    @params       = {}
    @article      = FactoryGirl.build(:article)
    @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @params
  end


  describe 'has method valid?' do
    before(:each) do
      @invalid_params = @params.clone
    end

    describe 'will return blank errors.full_messages if' do
      after(:each) do
        expect(@article_form.valid?).to eq(true)
        expect(@article_form.errors.full_messages.length).to eq(0)
      end

      it 'fills all params' do
        @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @params
      end  

      it 'has title_ru and content_ru and image_ru but title_en, content_en and image_en is blank' do
        @invalid_params[:title_en]   = nil
        @invalid_params[:content_en] = nil
        @invalid_params[:image_en]   = nil
        @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
      end
    end
    

    it 'will return error about not full info if does not has full info (title, image and content) on one of language' do
      @invalid_params[:title_ru]   = ''
      @invalid_params[:content_ru] = ''
      @invalid_params[:image_ru]   = ''
      @invalid_params[:title_en]   = ''
      @invalid_params[:content_en] = ''
      @invalid_params[:image_en]   = ''

      @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
      expect(@article_form.valid?).to eq(false)
      expect(@article_form.errors.full_messages.length).to eq(1)
      expect(@article_form.errors.full_messages.first.strip).to eq('Необходимо указать полную инфу о статье, хотя бы на одном языке (заголовок, описание, картинка)')
    end
  end


  describe 'has method save' do
    context "when create new" do
      context "with valid params" do
        it 'return true' do
          expect(@article_form.save).to eq(true)
        end

        it 'create new record' do
          expect {
              @article_form.save
              }.to change(Article, :count).by(1)
        end
      end
    end
  end



end
