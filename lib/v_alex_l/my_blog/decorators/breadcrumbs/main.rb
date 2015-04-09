class VAlexL::MyBlog::Decorators::Breadcrumbs::Main

  attr_reader :items
  def initialize
    @items = []
  end

  def add_item(title, path)
    items.push VAlexL::MyBlog::Decorators::Breadcrumbs::Item.new(title, path)
  end

  def render(tasty_breadcrumbs_template)
    printer = VAlexL::MyBlog::Decorators::Breadcrumbs::Printer.new  tasty_breadcrumbs_template.container,
                                                                    tasty_breadcrumbs_template.simple_item,
                                                                    tasty_breadcrumbs_template.last_item
    printer.render_items(items)
  end

end
