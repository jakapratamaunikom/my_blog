require 'rails_helper'


RSpec.describe VAlexL::MyBlog::Filters::Article do
  before(:each) do

    @tag1 = FactoryGirl.create(:tag)
    @tag2 = FactoryGirl.create(:tag)
    @tag3 = FactoryGirl.create(:tag)
    @tag4 = FactoryGirl.create(:tag)
    
    @article_with_tag_1_and_tag_2 = FactoryGirl.create(:article)
    @article_with_tag_1_and_tag_2.russian_content.tag_ids = [@tag1.id]
    @article_with_tag_1_and_tag_2.english_content.tag_ids = [@tag2.id]
    @article_with_tag_1_and_tag_2.russian_content.set_published!
    @article_with_tag_1_and_tag_2.english_content.set_published!
    @article_with_tag_3_and_tag_4 = FactoryGirl.create(:article)
    @article_with_tag_3_and_tag_4.russian_content.tag_ids = [@tag3.id]
    @article_with_tag_3_and_tag_4.english_content.tag_ids = [@tag4.id]
    @article_with_tag_3_and_tag_4.russian_content.set_published!
    @article_with_tag_3_and_tag_4.english_content.set_published!

    @article_with_tag_1 = FactoryGirl.create(:article)
    @article_with_tag_1.russian_content.tag_ids = [@tag1.id]
    @article_with_tag_1.russian_content.set_published!

    @article_with_tag_2 = FactoryGirl.create(:article)
    @article_with_tag_2.russian_content.tag_ids = [@tag2.id]
    @article_with_tag_2.russian_content.set_published!

    @article_with_tag_3 = FactoryGirl.create(:article)
    @article_with_tag_3.russian_content.tag_ids = [@tag3.id]
    @article_with_tag_3.russian_content.set_published!

    @article_with_tag_4 = FactoryGirl.create(:article)
    @article_with_tag_4.russian_content.tag_ids = [@tag4.id]
    @article_with_tag_4.russian_content.set_published!

  end

  describe 'has method get_records' do
    it 'return all Articles if give blank array' do
      @filter = VAlexL::MyBlog::Filters::Article.new []
      @filter.get_records.count).to eq(Tag.count)
    end

    it 'return all Articles if give nil' do
      @filter = VAlexL::MyBlog::Filters::Article.new nil
      @filter.get_records.count).to eq(Tag.count)
    end
      
    it 'return instance of Article::ActiveRecord_Relation ' do
      @filter = VAlexL::MyBlog::Filters::Article.new [@tag1.id]
      expect(@filter.get_records.class).to eq(Article::ActiveRecord_Relation)
    end

    it 'return articles which market tag1 for filter by tag1' do
      @filter = VAlexL::MyBlog::Filters::Article.new [@tag1.id]
      expect(@filter.get_records.count).to eq(2)
      expect(@filter.get_records.to_a).to eq([@article_with_tag_1_and_tag_2, @article_with_tag_1])
    end

    it 'return only published article' do
      @unpublished_article = FactoryGirl.create(:article)
      @unpublished_article.russian_content.set_unpublished!
      @unpublished_article.english_content.set_unpublished!
      @unpublished_article.russian_content.tag_ids = [@tag1.id]

      @filter = VAlexL::MyBlog::Filters::Article.new [@tag1.id]
      is_get_unpublished_article = @filter.get_records.include?(@unpublished_article)
      expect(is_get_unpublished_article).to eq(false)
    end

  end
  
end

