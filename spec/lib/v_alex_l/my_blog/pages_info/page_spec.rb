require 'rails_helper'

describe VAlexL::MyBlog::PagesInfo::Page do
  before(:each) do
    @data = {
              title:   'Заголовок что то там',
              content: 'Содержимое о себе.',
              image:   'Фотка так же о себе',
            }
    @page = VAlexL::MyBlog::PagesInfo::Page.new(@data)
  end

  describe "has method" do
    it "title which return given title" do
      expect(@page.title).to eq(@data[:title])
    end

    it "content which return given content" do
      expect(@page.content).to eq(@data[:content])
    end

    it "image which return given image" do
      expect(@page.image).to eq(@data[:image])
    end

    it "title= which set given title" do
      @page.title = 'new value' 
      expect(@page.title).to eq('new value')
    end

    it "content= which set given content" do
      @page.content = 'new value' 
      expect(@page.content).to eq('new value')
    end

    it "image= which set given image" do
      @page.image = 'new value' 
      expect(@page.image).to eq('new value')
    end

    it 'has method get_data' do
      @page.title   = '1'
      @page.content = '2'
      @page.image   = '3'

      expect(@page.get_data).to eq({title: '1', content: '2', image: '3'})
    end
  end
end
