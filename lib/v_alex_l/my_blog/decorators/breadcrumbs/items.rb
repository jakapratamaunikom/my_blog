class VAlexL::MyBlog::Decorators::Breadcrumbs::Items
  def initialize
    @items = []
  end

  def add(item, path)
    @items.push [item, path]
  end

  def get_all
    @items
  end
end