require 'rails_helper'


RSpec.describe VAlexL::MyBlog::FormObjects::Article do
  before(:all) do
    @ru_tag1 = FactoryGirl.create(:tag)
    @ru_tag2 = FactoryGirl.create(:tag)
    @en_tag1 = FactoryGirl.create(:tag)
    @en_tag2 = FactoryGirl.create(:tag)
  end
  
  before(:each) do
    @ru_content = FactoryGirl.build(:article_content)
    @en_content = FactoryGirl.build(:article_content)
    @params = {
      :ru_title             => @ru_content.title,
      :ru_content           => @ru_content.content,
      :ru_short_description => @ru_content.short_description,
      :ru_published         => @ru_content.published,
      :en_title             => @en_content.title,
      :en_content           => @en_content.content,
      :en_short_description => @en_content.short_description,
      :en_published         => @en_content.published,
    }
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

      it 'has ru_title and ru_content but en_title, en_content are blank' do
        @invalid_params[:en_title]   = nil
        @invalid_params[:en_content] = nil
        @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params

        expect(@invalid_params[:ru_title].present?).to eq(true)
        expect(@invalid_params[:en_title].present?).to eq(false)
        expect(@article_form.en_title.present?).to eq(false)
        expect(@article_form.ru_title.present?).to eq(true)
      end

      it 'has en_title and en_content and but ru_title, ru_content are blank' do
        @invalid_params[:ru_title]   = nil
        @invalid_params[:ru_content] = nil
        @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
      end

    end
    
    it 'will return false and errors.full_messages will have information about blank title if en_title and ru_title are blank' do
      @invalid_params[:en_title] = nil
      @invalid_params[:ru_title] = nil
      @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
      expect(@article_form.valid?).to eq(false)
      expect(@article_form.errors.full_messages.length).to eq(1)
      expect(@article_form.errors.full_messages.first.strip).to eq('Статья должна содержать заголовок хотя бы на одном языке')
    end

    it 'will return true and errors.full_messages will be false if just ru_title present and another fields blank' do
      @invalid_params[:ru_title]             = 'Title'
      @invalid_params[:ru_short_description] = ''
      @invalid_params[:ru_content]           = ''
      @invalid_params[:en_title]             = ''
      @invalid_params[:en_content]           = ''
      @invalid_params[:en_short_description] = ''
      
      @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params

      expect(@article_form.valid?).to eq(true)
      expect(@article_form.errors.full_messages.length).to eq(0)
    end

    it 'will return true and errors.full_messages will be false if just en_title present and another fields blank' do
      @invalid_params[:ru_title]             = ''
      @invalid_params[:ru_short_description] = ''
      @invalid_params[:ru_content]           = ''
      @invalid_params[:en_title]             = 'Title'
      @invalid_params[:en_content]           = ''
      @invalid_params[:en_short_description] = ''
      
      @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params

      expect(@article_form.valid?).to eq(true)
      expect(@article_form.errors.full_messages.length).to eq(0)
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

        it 'create new two ArticleConten records' do
          expect {
              @article_form.save
              }.to change(ArticleContent, :count).by(2)
        end

        it 'save all attributes' do
          @article_form.save
          @article.reload
          expect(@article.russian_content.title).to eq(@params[:ru_title])
          expect(@article.english_content.title).to eq(@params[:en_title])
          expect(@article.russian_content.content).to eq(@params[:ru_content])
          expect(@article.english_content.content).to eq(@params[:en_content])
          expect(@article.russian_content.short_description).to eq(@params[:ru_short_description])
          expect(@article.english_content.short_description).to eq(@params[:en_short_description])
          expect(@article.russian_content.tag_ids).to eq([@ru_tag1.id, @ru_tag2.id])
          expect(@article.english_content.tag_ids).to eq([@en_tag1.id, @en_tag2.id])
        end
      end

      describe "with invalid params" do
        before(:each) do
          @invalid_params[:ru_title]             = ''
          @invalid_params[:ru_content]           = ''
          @invalid_params[:ru_short_description] = ''
          @invalid_params[:en_title]             = ''
          @invalid_params[:en_content]           = ''
          @invalid_params[:en_short_description] = ''
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
          @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, @invalid_params
          expect(@article_form.save).to eq(false)
          expect(@article_form.ru_title).to eq(@invalid_params[:ru_title])
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

    it 'is_tag_selected? will return true if tag exclude in en_tags but includes in ru_tags and given ru lang' do
      expect(@article_form.is_tag_selected?(@ru_tag1, :ru)).to eq(true)
    end

    it 'is_tag_selected? will return true if tag includes in en_tags but exclude in ru_tags and given ru lang' do
      expect(@article_form.is_tag_selected?(@en_tag1, :ru)).to eq(false)
    end

    it 'is_tag_selected? will return false if tag excludes in ru_tags or en_tags' do
      ru_another_tag = FactoryGirl.create(:tag)
      expect(@article_form.is_tag_selected?(ru_another_tag, :ru)).to eq(false)
      expect(@article_form.is_tag_selected?(ru_another_tag, :en)).to eq(false)
    end

    it 'get_tag_ids which return ids all tags' do
      expect(@article_form.send(:get_tag_ids)).to eq([@ru_tag1.id, @ru_tag2.id, @en_tag1.id, @en_tag2.id])
    end

    it 'ru_title= wich save title for article_content with russian language' do
      @article_form.ru_title= 'Русский заголовок'
      expect(@article_form.article.russian_content.title).to eq('Русский заголовок')
    end

    it 'en_title= wich save title for article_content with english language' do
      @article_form.en_title = 'English title'
      expect(@article_form.article.english_content.title).to eq('English title')
    end

    it 'ru_content= wich save image for article_content with russian language' do
      @article_form.ru_content= 'Что-то умное на русском языке'
      expect(@article_form.article.russian_content.content).to eq('Что-то умное на русском языке')
    end

    it 'en_content= wich save image for article_content with english language' do
      @article_form.en_content = 'Что-то умное на русском языке'
      expect(@article_form.article.english_content.content).to eq('Что-то умное на русском языке')
    end

    it 'image= wich save image for article' do
      File.open("#{::Rails.root}/spec/files/img.jpeg") do |f|
        @article.image= f
      end
      filename = File.basename(@article.image.file.file)
      expect(filename).to eq("img.jpeg")
    end

    it 'ru_published= wich save published for article_content with russian language' do
      @article_form.ru_published= true
      expect(@article_form.article.russian_content.published).to eq(true)
      @article_form.ru_published = false
      expect(@article_form.article.russian_content.published).to eq(false)
    end
    
    it 'en_published= wich save published for article_content with english language' do
      @article_form.en_published = true
      expect(@article_form.article.english_content.published).to eq(true)
      @article_form.en_published = false
      expect(@article_form.article.english_content.published).to eq(false)
    end

  end

end
