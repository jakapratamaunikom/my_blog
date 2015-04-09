class VAlexL::MyBlog::Decorators::Breadcrumbs::Items
  class Item
    include Rails.application.routes.url_helpers

    attr_reader :title, :route_helper_method
    def initialize(title, route_helper_method)
      @title = title
      @route_helper_method  = route_helper_method
    end

    def url
      send(route_helper_method)
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