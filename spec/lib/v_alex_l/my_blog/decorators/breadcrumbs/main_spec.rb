require 'rails_helper'


RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs::Main do
  before(:each) do
    VAlexL::MyBlog::Decorators::Breadcrumbs::Main.reset_items 
    @breadcrumbs = VAlexL::MyBlog::Decorators::Breadcrumbs::Main.new
  end


  describe 'has method of class' do
    it 'items which return instance of VAlexL::MyBlog::Decorators::Breadcrumbs::Items' do
      items = VAlexL::MyBlog::Decorators::Breadcrumbs::Main.items
      expect(items.instance_of?(VAlexL::MyBlog::Decorators::Breadcrumbs::Items)).to eq(true)
    end

    it 'printer which return instance of VAlexL::MyBlog::Decorators::Breadcrumbs::Printer' do
      printer = VAlexL::MyBlog::Decorators::Breadcrumbs::Main.printer
      expect(printer.instance_of?(VAlexL::MyBlog::Decorators::Breadcrumbs::Printer)).to eq(true)
    end

    it 'methods add_item which add new item to breadcrumbs items and get_items which returns all breadcrumbs items' do
      expect(VAlexL::MyBlog::Decorators::Breadcrumbs::Main.get_items).to eq([])
      VAlexL::MyBlog::Decorators::Breadcrumbs::Main.add_item('Main', :root_path)
      expect(VAlexL::MyBlog::Decorators::Breadcrumbs::Main.get_items).to eq([['Main', :root_path]])
    end
  end

  it 'has method render which return html_safe template' do
    VAlexL::MyBlog::Decorators::Breadcrumbs::Main.add_item('Main', :root_path)
    VAlexL::MyBlog::Decorators::Breadcrumbs::Main.add_item('Another page', :some_another_path)
    expect(@breadcrumbs.render).to eq("<ol class=\"breadcrumb\"><li><a href=\"/\">Main</a></li><li>Another page</li></ol>".html_safe)
  end
  
end

