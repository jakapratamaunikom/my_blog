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
    it 'title which returns title in given languages' do
      @article.title_ru = 'Заголовок'
      @article.title_en = 'Title'
      expect(@article.title(:ru)).to eq('Заголовок')
      expect(@article.title('ru')).to eq('Заголовок')
      expect(@article.title(:en)).to eq('Title')
      expect(@article.title('en')).to eq('Title')
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
  end
end
