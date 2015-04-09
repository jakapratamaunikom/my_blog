class VAlexL::MyBlog::Decorators::Breadcrumbs::Items
  class Item
    include Rails.application.routes.url_helpers

    attr_reader :title
    def initialize(title, url_or_route_helper_method)
      @title = title
      @url_or_route_helper_method  = url_or_route_helper_method
    end

    def url
      return @url_or_route_helper_method if @url_or_route_helper_method.instance_of?(String)
      send(@url_or_route_helper_method)
    end
  end

  def initialize
    @items = []
  end

  def add(title, path)
    item = Item.new(title, path)
    @items.push item
  end

  def get_all
    @items
  end
end