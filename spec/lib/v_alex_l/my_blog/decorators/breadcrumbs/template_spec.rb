require 'rails_helper'


RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs::Template do
  before(:each) do
    @template = VAlexL::MyBlog::Decorators::Breadcrumbs::Template.new VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_CONTAINER_TEMPLATE,
                                                                     VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_SIMPLE_ITEM_TEMPLATE,
                                                                     VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_LAST_ITEM_TEMPLATE
  end
  describe 'has method' do
    it 'container and container=' do
      @template.container = 'div.container ul.my_breadcrumbs'
      expect(@template.container).to eq('div.container ul.my_breadcrumbs')
    end

    it 'simple_item and simple_item=' do
      @template.simple_item = 'li.simple_item span a'
      expect(@template.simple_item).to eq('li.simple_item span a')
    end

    it 'last_item and last_item=' do
      @template.last_item = 'li.last_item'
      expect(@template.last_item).to eq('li.last_item')
    end
  end
end