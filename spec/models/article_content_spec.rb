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

    it 'has blank article' do
      @article_content.article = nil
    end

    it 'has incorrect_lang' do
      @article_content.lang = 'incorrect_lang'
    end

  end

  describe 'has method' do
    it 'russian? return true if lang=:ru' do
      @article_content.lang = nil
      expect(@article_content.russian?).to eq(false)
      @article_content.lang = :ru
      expect(@article_content.russian?).to eq(true)
    end

    it 'english? return true if lang=:en' do
      @article_content.lang = nil
      expect(@article_content.english?).to eq(false)
      @article_content.lang = :en
      expect(@article_content.english?).to eq(true)
    end
  end

end
