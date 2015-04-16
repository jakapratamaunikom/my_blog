require 'rails_helper'


RSpec.describe VAlexL::MyBlog::FormObjects::Article do
  before(:each) do
    @params = FactoryGirl.build(:article).attributes
    @params.except!('id', 'created_at', 'updated_at')
    @invalid_params = @params.clone

    @article      = FactoryGirl.build(:article)
    @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @params
  end


  describe 'has method valid?' do
    describe 'will return blank errors.full_messages if' do
      after(:each) do
        expect(@article_form.valid?).to eq(true)
        expect(@article_form.errors.full_messages.length).to eq(0)
      end

      it 'fills all params' do
        @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @params
      end  

      it 'has title_ru and content_ru and but title_en, content_en and is blank' do
        @invalid_params[:title_en]   = nil
        @invalid_params[:content_en] = nil
        @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
      end

      it 'has title_en and content_en and but title_ru, content_ru and is blank' do
        @invalid_params[:title_ru]   = nil
        @invalid_params[:content_ru] = nil
        @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
      end
    end
    

    describe "with blank title_en, content_en" do
      before(:each) do
        @invalid_params[:title_en]   = ''
        @invalid_params[:content_en] = ''
      end

      after(:each) do
        expect(@article_form.valid?).to eq(false)
        expect(@article_form.errors.full_messages.length).not_to eq(0)
        expect(@article_form.errors.full_messages.first.strip).to eq(@expected_error_message)
      end
      
      it 'will return error about blank title_ru if title_ru is blank' do
        @invalid_params[:title_ru] = ''
        @expected_error_message    = 'Заголовок (ru) не может быть пустым'
        @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
      end

      it 'will return error about blank content_ru if content_ru is blank' do
        @invalid_params[:content_ru] = ''
        @expected_error_message    = 'Описание (ru) не может быть пустым'
        @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
      end

    end
  end


  describe 'has method save' do
    context "when create new" do
      describe "with valid params" do
        it 'return true' do
          expect(@article_form.save).to eq(true)
        end

        it 'create new record' do
          expect {
              @article_form.save
              }.to change(Article, :count).by(1)
        end
      end

      describe "with invalid params" do
        before(:each) do
          @invalid_params[:title_ru]   = ''
          @invalid_params[:content_ru] = ''
          @invalid_params[:title_en]   = ''
          @invalid_params[:content_en] = ''
          @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
        end

        it 'return false' do
          expect(@article_form.save).to eq(false)
        end

        it 'create new record' do
          expect {
              @article_form.save
              }.to change(Article, :count).by(0)
        end

        it 'return arcticle with new attributes' do
          @invalid_params[:title_ru] = 'Invalid params'
          @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
          expect(@article_form.save).to eq(false)
          expect(@article_form.article.title_ru).to eq(@invalid_params[:title_ru])
        end
      end
    end
  end



end
