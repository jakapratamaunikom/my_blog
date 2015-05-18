require 'rails_helper'

RSpec.describe Article, type: :model do
  before(:each) do
    @article = FactoryGirl.create(:article)
  end

  describe "will successfully save if" do
    after(:each) do
      expect(@article.save!).to eq(true)
    end
    
    it 'build from FactoryGirl' do
    end
  end

  describe 'has method' do
    it "count_comments" do
      @article.save!
      FactoryGirl.create(:comment, article: @article)
      expect(@article.count_comments).to eq(1)
    end
    
    it 'published? wiche return published status for given language' do
      @article.published_ru = false
      @article.published_en = false

      expect(@article.published?(:ru)).to eq(false)
      expect(@article.published?(:en)).to eq(false)
     
      @article.published_ru = true
      @article.published_en = true
    
      expect(@article.published?('ru')).to eq(true)
      expect(@article.published?('en')).to eq(true)
    end

    it 'toggle_published! change article as published for language to opposite of current' do
      @article.published_ru = false
      @article.published_en = true

      @article.toggle_published!(:ru)
      @article.toggle_published!('en')
      expect(@article.published?(:ru)).to eq(true)
      expect(@article.published?(:en)).to eq(false)
    end


    it 'set_published! mark article as published for language' do
      @article.published_ru = false
      @article.published_en = false

      @article.set_published!(:ru)
      @article.set_published!('en')
      expect(@article.published?(:ru)).to eq(true)
      expect(@article.published?(:en)).to eq(true)
    end

    it 'set_unpublished! mark article as unpublished for language' do
      @article.published_ru = true
      @article.published_en = true

      @article.set_unpublished!(:ru)
      @article.set_unpublished!('en')
      expect(@article.published?(:ru)).to eq(false)
      expect(@article.published?(:en)).to eq(false)
    end


    it 'title which returns title in given languages' do
      @article.title_ru = 'Заголовок'
      @article.title_en = 'Title'
      expect(@article.title(:ru)).to eq('Заголовок')
      expect(@article.title('ru')).to eq('Заголовок')
      expect(@article.title(:en)).to eq('Title')
      expect(@article.title('en')).to eq('Title')
    end

    it 'content which returns content in given languages' do
      @article.content_ru = 'Содержимое'
      @article.content_en = 'Content'
      expect(@article.content(:ru)).to eq('Содержимое')
      expect(@article.content('ru')).to eq('Содержимое')
      expect(@article.content(:en)).to eq('Content')
      expect(@article.content('en')).to eq('Content')
    end

    it 'fully_filled_ru? wich return true only if has title_ru content_ru and image_ru' do
       @article.title_ru  = nil
       @article.content_ru = nil
       @article.image_ru  = nil

       expect(@article.fully_filled_ru?).to eq(false)
       @article.title_ru  = 'Заголовок'
       expect(@article.fully_filled_ru?).to eq(false)
       @article.content_ru  = 'Описание'
       expect(@article.fully_filled_ru?).to eq(false)
       File.open("#{::Rails.root}/spec/files/img.jpeg") do |f|
          @article.image_ru  = f
        end
       expect(@article.image_ru.present?).to eq(true)
       expect(@article.fully_filled_ru?).to eq(true)
    end

    it 'fully_filled_en? wich return true only if has title_en content_en and image_en' do
       @article.title_en  = nil
       @article.content_en = nil
       @article.image_en  = nil

       expect(@article.fully_filled_en?).to eq(false)
       @article.title_en  = 'Заголовок'
       expect(@article.fully_filled_en?).to eq(false)
       @article.content_en  = 'Описание'
       expect(@article.fully_filled_en?).to eq(false)
       File.open("#{::Rails.root}/spec/files/img.jpeg") do |f|
          @article.image_en  = f
        end
       expect(@article.image_en.present?).to eq(true)
       expect(@article.fully_filled_en?).to eq(true)
    end

    it 'russian_content wich build new article_content' do
      @article.article_contents.destroy_all
      expect(@article.russian_content.class).to eq(ArticleContent)
      expect(@article.russian_content.lang).to eq('ru')
    end

    it 'russian_content wich given exist article_content' do
      @article.save!
      ru_article_content = FactoryGirl.create(:article_content, lang: :ru, article: @article)
      en_article_content = FactoryGirl.create(:article_content, lang: :en, article: @article)
      @article.reload
      expect(@article.article_contents.count).to eq(2)
      expect(@article.russian_content).to eq(ru_article_content)
    end

    it 'english_content wich build new article_content' do
      @article.article_contents.destroy_all
      expect(@article.english_content.class).to eq(ArticleContent)
      expect(@article.english_content.lang).to eq('en')
    end

    it 'russian_content wich given exist article_content' do
      @article.save!
      ru_article_content = FactoryGirl.create(:article_content, lang: :ru, article: @article)
      en_article_content = FactoryGirl.create(:article_content, lang: :en, article: @article)
      @article.reload
      expect(@article.article_contents.count).to eq(2)
      expect(@article.english_content).to eq(en_article_content)
    end

  end
end
