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

    it 'has blank lang' do
      @article.lang = nil
    end
  end


  describe "won't save if" do
    after(:each) do
      expect(@article.save).to eq(false)
    end

    it 'has blank title' do
      @article.title = nil
    end

    it 'has blank content' do
      @article.content = nil
    end

    it 'has blank image_path' do
      @article.image_path = nil
    end
  end


  it 'if lang blank it will generate ru lang by default after save' do
    @article.lang = nil
    @article.save!
    expect(@article.lang.to_sym).to eq(:ru)
  end
end
