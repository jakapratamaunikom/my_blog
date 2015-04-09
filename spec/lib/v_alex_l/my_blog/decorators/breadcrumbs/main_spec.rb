require 'rails_helper'


RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs::Main do
  before(:each) do
    @breadcrumbs = VAlexL::MyBlog::Decorators::Breadcrumbs::Main.new
  end


  describe 'has method' do
    it 'items which return array of instance of VAlexL::MyBlog::Decorators::Breadcrumbs::Item' do
      items = @breadcrumbs.items
      all_items_is_instance_of_breadcrumb_item = items.all?{|i| i.instance_of?(VAlexL::MyBlog::Decorators::Breadcrumbs::Item)}
      expect(all_items_is_instance_of_breadcrumb_item).to eq(true)
    end

    it 'methods add_item which add new item to breadcrumbs' do
      expect(@breadcrumbs.items).to eq([])
      @breadcrumbs.add_item('Main', :root_path)
      
      expect(@breadcrumbs.items.length).to eq(1)
    end
  
    it 'render by breadcrumb template which return html_safe string' do
      template = VAlexL::MyBlog::Decorators::Breadcrumbs::Template.new VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_CONTAINER_TEMPLATE,
                                                                      VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_SIMPLE_ITEM_TEMPLATE,
                                                                      VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_LAST_ITEM_TEMPLATE

      @breadcrumbs.add_item('Main', :root_path)
      @breadcrumbs.add_item('Another page', :some_another_path)
      expect(@breadcrumbs.render(template)).to eq("<ol class=\"breadcrumb\"><li><a href=\"/\">Main</a></li><li>Another page</li></ol>".html_safe)
    end
  end


  
end

