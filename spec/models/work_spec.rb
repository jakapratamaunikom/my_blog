require 'rails_helper'

RSpec.describe Work, type: :model do
  before(:each) do
    @work = FactoryGirl.build(:work)
  end

  describe "will successfully save if" do
    after(:each) do
      expect(@work.save!).to eq(true)
    end
    
    it 'build from FactoryGirl' do
    end
  end

  it 'create 2 WorkContent' do
    expect{
      @work.save!
    }.to change(WorkContent, :count).by(2)
  end

  describe 'has method' do

    it 'get_content wich return content for given lang' do
      expect(@work.get_content(:ru)).to eq(@work.russian_content)
      expect(@work.get_content(:en)).to eq(@work.english_content)
    end

    it 'russian_content wich build new work_content' do
      @work.work_contents.destroy_all
      expect(@work.russian_content.class).to eq(WorkContent)
      expect(@work.russian_content.lang).to eq('ru')
    end

    it 'russian_content wich given exist work_content' do
      @work.work_contents.destroy_all
      @work.save!
      ru_work_content = FactoryGirl.create(:work_content, lang: :ru, work: @work)
      en_work_content = FactoryGirl.create(:work_content, lang: :en, work: @work)
      @work.reload
      expect(@work.work_contents.count).to eq(2)
      expect(@work.russian_content).to eq(ru_work_content)
    end

    it 'english_content wich build new work_content' do
      @work.work_contents.destroy_all
      expect(@work.english_content.class).to eq(WorkContent)
      expect(@work.english_content.lang).to eq('en')
    end

    it 'russian_content wich given exist work_content' do
      @work.work_contents.destroy_all 
      @work.save!
      ru_work_content = FactoryGirl.create(:work_content, lang: :ru, work: @work)
      en_work_content = FactoryGirl.create(:work_content, lang: :en, work: @work)
      @work.reload
      expect(@work.work_contents.count).to eq(2)
      expect(@work.english_content).to eq(en_work_content)
    end

  end
end
