class VAlexL::MyBlog::Decorators::Breadcrumbs::Template

  attr_accessor :container, :simple_item, :last_item

  def initialize(container, simple_item, last_item)
    @container   = container
    @simple_item = simple_item
    @last_item   = last_item
  end
end
