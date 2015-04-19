require 'rails_helper'

RSpec.describe VAlexL::MyBlog::PagesInfo::AboutMe do
  before(:each) do
    @default_values     = { about_me: {
                                        ru: {
                                            title:   'Заголовок что то там',
                                            content: 'Содержимое о себе.',
                                            image:   'Фотка так же о себе',
                                        },
                                        en: {
                                            title:   'Title',
                                            content: 'Content',
                                            image:   'photo',
                                        }
                                      }
                          }
    File.open(get_mock_path_to_page_info_file, 'w') {|f| f.write @default_values.to_yaml }
    
    expect(VAlexL::MyBlog::PagesInfo::AboutMe::PATH_TO_FILE).to eq(get_mock_path_to_page_info_file)
  end

  describe 'for ru' do
    before(:each) do
      @pages_info = VAlexL::MyBlog::PagesInfo::AboutMe.new :ru
    end

    it 'has method page which return instance of Page which should work with ru data' do
      expect(@pages_info.page.class).to eq(VAlexL::MyBlog::PagesInfo::Page)
      expect(@pages_info.page.get_data).to eq(@default_values[:about_me][:ru])
    end

    it 'has method save wich save changes in page' do
      @pages_info.page.title   = 'Новый заголовок'
      @pages_info.page.content = 'Новый содержмиый'
      @pages_info.page.image   = 'Новый картинка'
      @pages_info.save
      data =  YAML::load_file(get_mock_path_to_page_info_file)
      expect(data[:about_me][:en]).to eq(@default_values[:about_me][:en])

      expect(data[:about_me][:ru][:title]).to   eq('Новый заголовок')
      expect(data[:about_me][:ru][:content]).to eq('Новый содержмиый')
      expect(data[:about_me][:ru][:image]).to   eq('Новый картинка')
    end
  end

  describe 'for en' do
    before(:each) do
      @pages_info = VAlexL::MyBlog::PagesInfo::AboutMe.new :en
    end

    it 'has method page which return instance of Page which should work with en data' do
      expect(@pages_info.page.class).to eq(VAlexL::MyBlog::PagesInfo::Page)
      expect(@pages_info.page.get_data).to eq(@default_values[:about_me][:en])
    end

    it 'has method save wich save changes in page' do
      @pages_info.page.title   = 'New title'
      @pages_info.page.content = 'New content'
      @pages_info.page.image   = 'New image'
      @pages_info.save
      data =  YAML::load_file(get_mock_path_to_page_info_file)
      expect(data[:about_me][:ru]).to eq(@default_values[:about_me][:ru])

      expect(data[:about_me][:en][:title]).to   eq('New title')
      expect(data[:about_me][:en][:content]).to eq('New content')
      expect(data[:about_me][:en][:image]).to   eq('New image')
    end
  end
end

