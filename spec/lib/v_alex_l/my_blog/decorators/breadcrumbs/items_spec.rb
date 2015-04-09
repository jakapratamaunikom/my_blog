require 'rails_helper'

RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs::Items::Item do
  before(:each) do
    allow(VAlexL::MyBlog::Decorators::Breadcrumbs::Items::Item).to receive(:admin_root_path).and_return('/admin')
    @title = 'Title of page'
    @url_or_route_helper_method = :admin_root_path
    @item = VAlexL::MyBlog::Decorators::Breadcrumbs::Items::Item.new @title, @url_or_route_helper_method
  end

  it 'has method title returns Title of page' do
    expect(@item.title).to eq(@title)
  end

  describe 'has_method url' do
    it 'try execute route helper if url_or_route_helper_method is symbol' do
      expect(@item.url).to eq('/admin')
    end
    
    it 'nothing do if url_or_route_helper_method is string' do
      @item = VAlexL::MyBlog::Decorators::Breadcrumbs::Items::Item.new @title, '/some_string_is_path'
      expect(@item.url).to eq('/some_string_is_path')
    end
  end
end

RSpec.describe VAlexL::MyBlog::Decorators::Breadcrumbs::Items do
  before(:each) do
    @items = VAlexL::MyBlog::Decorators::Breadcrumbs::Items.new
  end

  it 'has_method add for adding items and get_all for getting all items' do
    expect(@items.get_all).to eq([])
    @items.add('Main', :route_helper_method)
    expect(@items.get_all.length).to eq(1)
    expect(@items.get_all.first.instance_of?(VAlexL::MyBlog::Decorators::Breadcrumbs::Items::Item)).to eq(true)
  end

end
