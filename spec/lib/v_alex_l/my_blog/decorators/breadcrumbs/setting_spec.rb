require 'rails_helper'


RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs::Setting do
  before(:each) do
    @setting = VAlexL::MyBlog::Decorators::Breadcrumbs::Setting.new VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_CONTAINER_TEMPLATE,
                                                                    VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_SIMPLE_ITEM_TEMPLATE,
                                                                    VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_LAST_ITEM_TEMPLATE
  end
  describe 'has method' do
    it 'container_template and container_template=' do
      @setting.container_template = 'div.container ul.my_breadcrumbs'
      expect(@setting.container_template).to eq('div.container ul.my_breadcrumbs')
    end

    it 'simple_item_template and simple_item_template=' do
      @setting.simple_item_template = 'li.simple_item span a'
      expect(@setting.simple_item_template).to eq('li.simple_item span a')
    end

    it 'last_item_template and last_item_template=' do
      @setting.last_item_template = 'li.last_item'
      expect(@setting.last_item_template).to eq('li.last_item')
    end
  end
end