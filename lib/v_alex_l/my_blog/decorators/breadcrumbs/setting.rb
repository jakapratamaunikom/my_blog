class VAlexL::MyBlog::Decorators::Breadcrumbs::Setting
  # Information about templates
  attr_accessor :container_template, :simple_item_template, :last_item_template
  def initialize(container_template, simple_item_template, last_item_template)
    @container_template   = container_template
    @simple_item_template = simple_item_template
    @last_item_template   = last_item_template
  end
end
