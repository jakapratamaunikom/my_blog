require 'rails_helper'

RSpec.describe VAlexL::MyBlog::Search::Article do
  describe 'method search' do
    before(:each) do
      Article.destroy_all
      @article = FactoryGirl.create(:article)
    end

    it 'empty search' do
      @search_article = described_class.new(nil)
      expect(@search_article.search).to eq([@article])
    end

    it 'nonexistent title' do
      @search_article = described_class.new("test")
      expect(@search_article.search).to eq([])
    end

    it 'exist title' do
      content = @article.get_content('ru')
      ArticleContent.update(content.id, :title => "тест")
      @search_article = described_class.new("тест")
      expect(@search_article.search).to eq([@article])
    end
  end
end
