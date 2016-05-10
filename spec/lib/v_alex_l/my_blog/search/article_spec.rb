require 'rails_helper'

RSpec.describe VAlexL::MyBlog::Search::Article do
  describe 'method search' do
    before(:each) do
      Article.destroy_all
    end

    it 'empty search' do
      @search_article = VAlexL::MyBlog::Search::Article.new (nil)
      article = FactoryGirl.create(:article)
      expect(@search_article.search).to eq([article])
    end

    it 'nonexistent title' do
      @search_article = VAlexL::MyBlog::Search::Article.new("test")
      article = FactoryGirl.create(:article)
      expect(@search_article.search).to eq([])
    end

    it 'exist title' do
      @search_article = VAlexL::MyBlog::Search::Article.new("Lor")
      article = FactoryGirl.create(:article)
      expect(@search_article.search).to eq([article])
    end
  end
end
