require 'rails_helper'


RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs::Items do
  before(:each) do
    @items = VAlexL::MyBlog::Decorators::Breadcrumbs::Items.new
  end

  it 'has_method add for adding items and get_all for getting all items' do
    expect(@items.get_all).to eq([])
    @items.add('Main', :route_helper_method)
    expect(@items.get_all).to eq([['Main', :route_helper_method]])
  end

end

RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs::Printer do
  before(:each) do
    allow(VAlexL::MyBlog::Decorators::Breadcrumbs::Printer).to receive(:root_path).and_return('/')
    allow(VAlexL::MyBlog::Decorators::Breadcrumbs::Printer).to receive(:some_another_path).and_return('/some_another_path')

    @printer = VAlexL::MyBlog::Decorators::Breadcrumbs::Printer.new
  end

  describe 'has method' do
    it 'render_single_item' do
      item = ['Main', :root_path]
      expect(@printer.render_single_item(item)).to eq("<li><a href=\"/\">Main</a></li>".html_safe)
    end

    it 'render_last_item' do
      item = ['Main', :root_path]
      expect(@printer.render_last_item(item)).to eq("<li>Main</li>".html_safe)
    end

    it 'render_items' do
      first_item = ['Main', :root_path]
      last_item  = ['Another page', :some_another_path]
      items      = [first_item, last_item]

      expect(@printer.render_items(items)).to eq("<ol class=\"breadcrumbs\"><li><a href=\"/\">Main</a></li><li>Another page</li></ol>".html_safe)
    end

  end

end




RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs do
  before(:each) do
    VAlexL::MyBlog::Decorators::Breadcrumbs.reset_items 
    
    
    @breadcrumbs = VAlexL::MyBlog::Decorators::Breadcrumbs.new
  end


  describe 'has method of class' do
    it 'items which return instance of VAlexL::MyBlog::Decorators::Breadcrumbs::Items' do
      items = VAlexL::MyBlog::Decorators::Breadcrumbs.items
      expect(items.instance_of?(VAlexL::MyBlog::Decorators::Breadcrumbs::Items)).to eq(true)
    end

    it 'printer which return instance of VAlexL::MyBlog::Decorators::Breadcrumbs::Printer' do
      printer = VAlexL::MyBlog::Decorators::Breadcrumbs.printer
      expect(printer.instance_of?(VAlexL::MyBlog::Decorators::Breadcrumbs::Printer)).to eq(true)
    end

    it 'methods add_item which add new item to breadcrumbs items and get_items which returns all breadcrumbs items' do
      expect(VAlexL::MyBlog::Decorators::Breadcrumbs.get_items).to eq([])
      VAlexL::MyBlog::Decorators::Breadcrumbs.add_item('Main', :root_path)
      expect(VAlexL::MyBlog::Decorators::Breadcrumbs.get_items).to eq([['Main', :root_path]])
    end
  end

  it 'has method render which return html_safe template' do
    VAlexL::MyBlog::Decorators::Breadcrumbs.add_item('Main', :root_path)
    VAlexL::MyBlog::Decorators::Breadcrumbs.add_item('Another page', :some_another_path)
    expect(@breadcrumbs.render).to eq("<ol class=\"breadcrumbs\"><li><a href=\"/\">Main</a></li><li>Another page</li></ol>".html_safe)
  end
  
end

