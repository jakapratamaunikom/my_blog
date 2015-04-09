class VAlexL::MyBlog::Decorators::Breadcrumbs::Printer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TagHelper
  include ActionView::Context
  
  attr_reader :container, :single_item, :last_item
  def initialize
    @container   = 'ol.breadcrumb'
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
    content_tag :ol, class: 'breadcrumb' do
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
