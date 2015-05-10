require 'rails_helper'


RSpec.describe VAlexL::MyBlog::FormObjects::Article do
  before(:all) do
    @ru_tag1 = FactoryGirl.create(:tag, lang: :ru)
    @ru_tag2 = FactoryGirl.create(:tag, lang: :ru)
    @en_tag1 = FactoryGirl.create(:tag, lang: :en)
    @en_tag2 = FactoryGirl.create(:tag, lang: :en)
  end
  
  before(:each) do
    @params = FactoryGirl.build(:article).attributes
    @params.except!('id', 'created_at', 'updated_at')
    @params.merge!('ru_tags' => [@ru_tag1.id, @ru_tag2.id])
    @params.merge!('en_tags' => [@en_tag1.id, @en_tag2.id])
    @invalid_params = @params.clone

    @article      = FactoryGirl.build(:article)
    @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @params
  end


  describe 'has method valid?' do
    describe 'will return true and blank errors.full_messages if' do
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
    
    it 'will return false and errors.full_messages will have information about blank title if title_en and title_ru are blank' do
      @invalid_params[:title_en] = nil
      @invalid_params[:title_ru] = nil
      @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
      expect(@article_form.valid?).to eq(false)
      expect(@article_form.errors.full_messages.length).to eq(1)
      expect(@article_form.errors.full_messages.first.strip).to eq('Статья должна содержать заголовок хотя бы на одном языке')
    end


    it 'will return false and errors.full_messages will have information about blank content if title_ru present but content_ru, title_en and content_en blank' do
      @invalid_params[:title_ru]   = 'Title'
      @invalid_params[:content_ru] = ''
      @invalid_params[:title_en]   = ''
      @invalid_params[:content_en] = ''
      @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params

      expect(@article_form.valid?).to eq(false)
      expect(@article_form.errors.full_messages.length).to eq(1)
      expect(@article_form.errors.full_messages.first.strip).to eq('Описание (ru) не может быть пустым')
    end

    it 'will return false and errors.full_messages will have information about blank content if title_en present but content_en, title_ru and content_ru blank' do
      @invalid_params[:title_en]   = 'Title'
      @invalid_params[:content_en] = ''
      @invalid_params[:title_ru]   = ''
      @invalid_params[:content_ru] = ''
      @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params

      expect(@article_form.valid?).to eq(false)
      expect(@article_form.errors.full_messages.length).to eq(1)
      expect(@article_form.errors.full_messages.first.strip).to eq('Описание (en) не может быть пустым')
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

        it 'save all attributes' do
          @article_form.save
          @article.reload
          expect(@article.title_ru).to eq(@params['title_ru'])
          expect(@article.title_en).to eq(@params['title_en'])
          expect(@article.content_ru).to eq(@params['content_ru'])
          expect(@article.content_en).to eq(@params['content_en'])
          expect(@article.ru_tag_ids).to eq([@ru_tag1.id, @ru_tag2.id])
          expect(@article.en_tag_ids).to eq([@en_tag1.id, @en_tag2.id])
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

        it 'does not create new record' do
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


  describe 'has method' do
    it 'ru_tags wich return given params' do
      expect(@article_form.ru_tags).to eq(@params['ru_tags'])
    end

    it 'en_tags wich return given params' do
      expect(@article_form.en_tags).to eq(@params['en_tags'])
    end

    it 'is_tag_selected? will return true if tag includes in ru_tags or en_tags' do
      expect(@article_form.is_tag_selected?(@ru_tag1)).to eq(true)
      expect(@article_form.is_tag_selected?(@en_tag1)).to eq(true)
    end

    it 'is_tag_selected? will return false if tag excludes in ru_tags or en_tags' do
      another_ru_tag = FactoryGirl.create(:tag, lang: :ru)
      another_en_tag = FactoryGirl.create(:tag, lang: :en)
      expect(@article_form.is_tag_selected?(another_ru_tag)).to eq(false)
      expect(@article_form.is_tag_selected?(another_en_tag)).to eq(false)
    end

    it 'get_tag_ids which return ids all tags' do
      expect(@article_form.send(:get_tag_ids)).to eq([@ru_tag1.id, @ru_tag2.id, @en_tag1.id, @en_tag2.id])
    end
  end
  

end
