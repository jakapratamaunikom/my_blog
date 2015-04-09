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
