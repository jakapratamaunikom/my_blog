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

    it 'fully_filled? wich will return true only if has title content and image_ru' do
       @article_content.title   = nil
       @article_content.content = nil
       allow(@article_content.image).to receive(:file).and_return(nil)

       expect(@article_content.fully_filled?).to eq(false)
       @article_content.title  = 'Заголовок'
       expect(@article_content.fully_filled?).to eq(false)
       @article_content.content  = 'Описание'
       expect(@article_content.fully_filled?).to eq(false)
       File.open("#{::Rails.root}/spec/files/img.jpeg") do |f|
          allow(@article_content.image).to receive(:file).and_return(f)
        end
       expect(@article_content.image.present?).to eq(true)
       expect(@article_content.fully_filled?).to eq(true)
    end

  end

end
