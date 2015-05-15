require 'rails_helper'

RSpec.describe ArticleContent, type: :model do
  before(:each) do
    @article_content = FactoryGirl.build(:article_content)
  end

  it 'will successful save if builds from FactoryGirl' do
    expect(@article_content.save!).to eq(true)
  end

  describe 'will not save if' do
    after(:each) do
      expect(@article_content.save).to eq(false)
    end

    it 'has blank title' do
      @article_content.title = nil      
    end

    it 'has blank content' do
      @article_content.content = nil      
    end    

    it 'has blank article' do
      @article_content.article = nil
    end

    it 'has incorrect_lang' do
      @article_content.lang = 'incorrect_lang'
    end

  end

end
