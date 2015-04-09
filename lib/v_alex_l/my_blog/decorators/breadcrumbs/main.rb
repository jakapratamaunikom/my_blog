class VAlexL::MyBlog::Decorators::Breadcrumbs::Main

  attr_reader :items
  def initialize
    @items = []
  end

  def add_item(title, path)
    items.push VAlexL::MyBlog::Decorators::Breadcrumbs::Item.new(title, path)
  end

  def render(tasty_breadcrumb_setting)
    printer = VAlexL::MyBlog::Decorators::Breadcrumbs::Printer.new  tasty_breadcrumb_setting.container_template,
                                                                    tasty_breadcrumb_setting.simple_item_template,
                                                                    tasty_breadcrumb_setting.last_item_template
    printer.render_items(items)
  end

end
