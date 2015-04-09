require 'rails_helper'


RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs::Main do
  before(:each) do
    @breadcrumbs = VAlexL::MyBlog::Decorators::Breadcrumbs::Main.new
  end


  describe 'has method' do
    it 'items which return instance of VAlexL::MyBlog::Decorators::Breadcrumbs::Items' do
      items = @breadcrumbs.items
      expect(items.instance_of?(VAlexL::MyBlog::Decorators::Breadcrumbs::Items)).to eq(true)
    end

    it 'methods add_item which add new item to breadcrumbs' do
      expect(@breadcrumbs.items.get_all).to eq([])
      @breadcrumbs.add_item('Main', :root_path)
      expect(@breadcrumbs.items.get_all).to eq([['Main', :root_path]])
    end
  
    it 'render by settings which return html_safe string' do
      setting = VAlexL::MyBlog::Decorators::Breadcrumbs::Setting.new VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_CONTAINER_TEMPLATE,
                                                                      VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_SIMPLE_ITEM_TEMPLATE,
                                                                      VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_LAST_ITEM_TEMPLATE

      @breadcrumbs.add_item('Main', :root_path)
      @breadcrumbs.add_item('Another page', :some_another_path)
      expect(@breadcrumbs.render(setting)).to eq("<ol class=\"breadcrumb\"><li><a href=\"/\">Main</a></li><li>Another page</li></ol>".html_safe)
    end
  end


  
end

