require 'rails_helper'

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

      expect(@printer.render_items(items)).to eq("<ol class=\"breadcrumb\"><li><a href=\"/\">Main</a></li><li>Another page</li></ol>".html_safe)
    end

  end

end

