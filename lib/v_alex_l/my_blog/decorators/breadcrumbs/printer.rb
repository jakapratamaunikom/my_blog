class VAlexL::MyBlog::Decorators::Breadcrumbs::Printer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TagHelper
  include ActionView::Context
  
  attr_reader :container, :simple_item, :last_item
  def initialize(container='ol.breadcrumb', simple_item='li a', last_item='li')
    @container   = container
    @simple_item = simple_item
    @last_item   = last_item
  end

  def render_simple_item(item)
    render_item_by_template simple_item.clone, item
  end

  def render_last_item(item)
    render_item_by_template last_item.clone, item
  end

  def render_items(items)
    render_container_by_template container.clone, items
  end

  private

    def render_items_in_container(items)
      items.inject("".html_safe) do |res, item|
        res +=  if item == items.last
                  render_last_item(item)
                else
                  render_simple_item(item)
                end
      end
    end

    def render_container_by_template(template, items)
      return render_items_in_container(items) if template.blank?

      tag_with_classes = template.split(' ')[0]
      html_tag         = tag_with_classes.split(".")[0]
      html_classes     = tag_with_classes.split(".")[1..-1].join(" ")
      options = {}
      options[:class] = html_classes if html_classes.present?
      content_tag html_tag, options do
        template.slice!(tag_with_classes)
        render_container_by_template template.strip!, items
      end      
    end

    def render_item_by_template(template, item)
      return item[0] if template.blank?
      tag_with_classes = template.split(' ')[0]
      html_tag         = tag_with_classes.split(".")[0]
      html_classes     = tag_with_classes.split(".")[1..-1].join(" ")
      options = {}
      options[:class] = html_classes if html_classes.present?
      options[:href]  = send(item[1]) if html_tag.eql?('a')
      content_tag html_tag, options do
        template.slice!(tag_with_classes)
        render_item_by_template template.strip!, item
      end
    end
end
