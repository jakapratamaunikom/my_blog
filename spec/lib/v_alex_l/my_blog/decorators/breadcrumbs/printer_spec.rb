require 'rails_helper'

RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs::Printer do
  before(:each) do
    allow(VAlexL::MyBlog::Decorators::Breadcrumbs::Printer).to receive(:root_path).and_return('/')
    allow(VAlexL::MyBlog::Decorators::Breadcrumbs::Printer).to receive(:some_another_path).and_return('/some_another_path')

    @printer = VAlexL::MyBlog::Decorators::Breadcrumbs::Printer.new
  end

  describe 'has method' do
    it 'render_simple_item' do
      item = ['Main', :root_path]
      expect(@printer.render_simple_item(item)).to eq("<li><a href=\"/\">Main</a></li>".html_safe)
    end

    it 'render_last_item' do
      item = ['Main', :root_path]
      expect(@printer.render_last_item(item)).to eq("<li>Main</li>".html_safe)
    end

    it 'render_items' do
      first_item = ['Main', :root_path]
      last_item  = ['Another page', :some_another_path]
      items      = [first_item, last_item]

      expect(@printer.render_items(items)).to eq("<ol class=\"breadcrumb\"><li><a href=\"/\">Main</a></li><li>Another page</li></ol>".html_safe)
    end
  end

  describe 'can set another template for breadcrumb' do
    before(:each) do
      @printer = VAlexL::MyBlog::Decorators::Breadcrumbs::Printer.new 'ul.my_breadcrumb', 'li.simple_item a.a_simple_item', 'li.last_item span.s_last_item'
    end

    it 'setup in constructor' do
      expect(@printer.container).to eq('ul.my_breadcrumb')
      expect(@printer.simple_item).to eq('li.simple_item a.a_simple_item')
      expect(@printer.last_item).to eq('li.last_item span.s_last_item')
    end

    it 'render_simple_item by new template' do
      first_item = ['Main', :root_path]
      expect(@printer.render_simple_item(first_item)).to eq("<li class=\"simple_item\"><a class=\"a_simple_item\" href=\"/\">Main</a></li>".html_safe)
    end

    it 'render_last_item by new template' do
      last_item  = ['Another page', :some_another_path]
      expect(@printer.render_last_item(last_item)).to eq("<li class=\"last_item\"><span class=\"s_last_item\">Another page</span></li>".html_safe)
    end

    it 'render_items by new template' do
      first_item = ['Main', :root_path]
      last_item  = ['Another page', :some_another_path]
      items      = [first_item, last_item]

      expect(@printer.render_items(items)).to eq("<ul class=\"my_breadcrumb\"><li class=\"simple_item\"><a class=\"a_simple_item\" href=\"/\">Main</a></li><li class=\"last_item\"><span class=\"s_last_item\">Another page</span></li></ul>".html_safe)
    end

  end

end

