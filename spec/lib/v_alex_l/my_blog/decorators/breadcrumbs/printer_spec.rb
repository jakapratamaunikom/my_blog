require 'rails_helper'

RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs::Printer do
  before(:each) do
    @printer = VAlexL::MyBlog::Decorators::Breadcrumbs::Printer.new VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_CONTAINER_TEMPLATE, 
                                                                    VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_SIMPLE_ITEM_TEMPLATE, 
                                                                    VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_LAST_ITEM_TEMPLATE
    @first_item = VAlexL::MyBlog::Decorators::Breadcrumbs::Item.new 'Main', :root_path
    @last_item  = VAlexL::MyBlog::Decorators::Breadcrumbs::Item.new 'Another page', :some_another_path
    @items      = [@first_item, @last_item]
  end

  describe 'has method' do
    it 'render_simple_item' do
      expect(@printer.render_simple_item(@first_item)).to eq("<li><a href=\"/\">Main</a></li>".html_safe)
    end

    it 'render_last_item' do
      expect(@printer.render_last_item(@first_item)).to eq("<li>Main</li>".html_safe)
    end

    it 'render_items' do
      expect(@printer.render_items(@items)).to eq("<ol class=\"breadcrumb\"><li><a href=\"/\">Main</a></li><li>Another page</li></ol>".html_safe)
    end
  end

  describe 'can set another template for breadcrumb' do
    before(:each) do
      @printer = VAlexL::MyBlog::Decorators::Breadcrumbs::Printer.new 'ul.my_breadcrumb', 'li.simple_item a.a_simple_item', 'li.last_item span.s_last_item'
    end

    it 'setup in constructor' do
      expect(@printer.container_template).to eq('ul.my_breadcrumb')
      expect(@printer.simple_item_template).to eq('li.simple_item a.a_simple_item')
      expect(@printer.last_item_template).to eq('li.last_item span.s_last_item')
    end

    it 'render_simple_item by new template' do
      expect(@printer.render_simple_item(@first_item)).to eq("<li class=\"simple_item\"><a class=\"a_simple_item\" href=\"/\">Main</a></li>".html_safe)
    end

    it 'render_last_item by new template' do
      expect(@printer.render_last_item(@last_item)).to eq("<li class=\"last_item\"><span class=\"s_last_item\">Another page</span></li>".html_safe)
    end

    it 'render_items by new template' do
      expect(@printer.render_items(@items)).to eq("<ul class=\"my_breadcrumb\"><li class=\"simple_item\"><a class=\"a_simple_item\" href=\"/\">Main</a></li><li class=\"last_item\"><span class=\"s_last_item\">Another page</span></li></ul>".html_safe)
    end

  end

end

