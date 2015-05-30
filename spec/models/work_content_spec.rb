require 'rails_helper'

RSpec.describe WorkContent, type: :model do
  before(:each) do
    @work_content = FactoryGirl.build(:work_content)
  end

  it 'will successful save if builds from FactoryGirl' do
    expect(@work_content.save!).to eq(true)
  end

  describe 'will not save if' do
    after(:each) do
      expect(@work_content.save).to eq(false)
    end

    it 'has blank work' do
      @work_content.work = nil
    end

    it 'has incorrect_lang' do
      @work_content.lang = 'incorrect_lang'
    end

  end

  describe 'has method' do
    it 'russian? return true if lang=:ru' do
      @work_content.lang = nil
      expect(@work_content.russian?).to eq(false)
      @work_content.lang = :ru
      expect(@work_content.russian?).to eq(true)
    end

    it 'english? return true if lang=:en' do
      @work_content.lang = nil
      expect(@work_content.english?).to eq(false)
      @work_content.lang = :en
      expect(@work_content.english?).to eq(true)
    end

    it 'fully_filled? wich will return true only if has title content and image_ru' do
       @work_content.title   = nil
       @work_content.content = nil
       allow(@work_content.image).to receive(:file).and_return(nil)

       expect(@work_content.fully_filled?).to eq(false)
       @work_content.title  = 'Заголовок'
       expect(@work_content.fully_filled?).to eq(false)
       @work_content.content  = 'Описание'
       expect(@work_content.fully_filled?).to eq(false)
       File.open("#{::Rails.root}/spec/files/img.jpeg") do |f|
          allow(@work_content.image).to receive(:file).and_return(f)
        end
       expect(@work_content.image.present?).to eq(true)
       expect(@work_content.fully_filled?).to eq(true)
    end

    it 'toggle_published! change work_content as published if it was unpublished' do
      @work_content.published = false

      @work_content.toggle_published!
      expect(@work_content.published?).to eq(true)
    end

    it 'toggle_published! change work_content as unpublished if it was published' do
      @work_content.published = true

      @work_content.toggle_published!
      expect(@work_content.published?).to eq(false)
    end

    it 'set_published! mark work_content as published' do
      @work_content.published = false

      @work_content.set_published!
      expect(@work_content.published?).to eq(true)
    end

    it 'set_unpublished! mark work_content as unpublished' do
      @work_content.published = true

      @work_content.set_unpublished!
      expect(@work_content.published?).to eq(false)
    end

  end

end
