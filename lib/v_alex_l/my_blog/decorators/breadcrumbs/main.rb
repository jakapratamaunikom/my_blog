class VAlexL::MyBlog::Decorators::Breadcrumbs::Main

  class << self
    def items
      @items ||= VAlexL::MyBlog::Decorators::Breadcrumbs::Items.new
      @items
    end

    def printer
      @printer ||= VAlexL::MyBlog::Decorators::Breadcrumbs::Printer.new container_template, simple_item_template, last_item_template
      @printer
    end

    def reset_items
      puts '!!!!!!!!!!'
      puts 'reset_items'
      puts '!!!!!!!!!!'
      @items = nil
    end

    def add_item(item, path)
      items.add item, path
    end

    def get_items
      items.get_all
    end

    def container_template
      return VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_CONTAINER_TEMPLATE unless @container_template
      @container_template
    end 

    def simple_item_template
      return VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_SIMPLE_ITEM_TEMPLATE unless @simple_item_template
      @simple_item_template
    end

    def last_item_template  
      return VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_LAST_ITEM_TEMPLATE unless @last_item_template  
      @last_item_template  
    end

    def render
      items = VAlexL::MyBlog::Decorators::Breadcrumbs::Main.get_items
      VAlexL::MyBlog::Decorators::Breadcrumbs::Main.printer.render_items(items)
    end
  end

end
