class VAlexL::MyBlog::Decorators::Breadcrumbs
  
  class Items
    def initialize
      @items = []
      # @container   = "ol.breadcrumbs"
      # @single_item = "li a"
      # @last_item   = "li"
    end

    def add(item, path)
      @items.push [item, path]
    end

    def get_all
      @items
    end
  end

  class Printer
    include Rails.application.routes.url_helpers
    include ActionView::Helpers::TagHelper
    include ActionView::Context
    
    attr_reader :container, :single_item, :last_item
    def initialize
      @container   = 'ol.breadcrumbs'
      @single_item = 'li a'
      @last_item   = 'li'
      
    end

    def render_single_item(item)
      title, route_helper_method = item
      path = send(route_helper_method)
      content_tag :li do
        content_tag :a, href: path do
          title
        end
      end
    end

    def render_last_item(item)
      title = item[0]
      content_tag :li do
        title
      end
    end

    def render_items(items)
      content_tag :ol, class: 'breadcrumbs' do
        items.inject("".html_safe) do |res, item|
          res +=  if item == items.last
                    render_last_item(item)
                  else
                    render_single_item(item)
                  end
        end
      end
    end
  end
  

  class << self
    def items
      @items ||= VAlexL::MyBlog::Decorators::Breadcrumbs::Items.new
      @items
    end

    def printer
      @printer ||= VAlexL::MyBlog::Decorators::Breadcrumbs::Printer.new
      @printer
    end

    def reset_items
      @items = nil
    end

    def add_item(item, path)
      items.add item, path
    end

    def get_items
      items.get_all
    end

    def set_container(container)
    end

    # def set_single_item(single_item)
    #   SIGNLE_ITEM = single_item
    # end

    # def set_last_item(last_item)
    #   LAST_ITEM = last_item
    # end
  end

  def render
    items = VAlexL::MyBlog::Decorators::Breadcrumbs.get_items
    VAlexL::MyBlog::Decorators::Breadcrumbs.printer.render_items(items)
  end
end
