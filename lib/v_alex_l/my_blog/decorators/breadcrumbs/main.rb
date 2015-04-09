class VAlexL::MyBlog::Decorators::Breadcrumbs::Main

  attr_reader :items
  def initialize
    @items ||= VAlexL::MyBlog::Decorators::Breadcrumbs::Items.new
  end

  def add_item(item, path)
    items.add item, path
  end

  def render(tasty_breadcrumb_setting)
    printer = VAlexL::MyBlog::Decorators::Breadcrumbs::Printer.new  tasty_breadcrumb_setting.container_template,
                                                                    tasty_breadcrumb_setting.simple_item_template,
                                                                    tasty_breadcrumb_setting.last_item_template
    printer.render_items(items.get_all)
  end

end
