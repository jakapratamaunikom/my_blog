module TastyBreadcrumbs::ActionController
  extend ActiveSupport::Concern

  included do
    before_action :setup_tasty_breadcrumbs
    helper_method :display_tasty_breadcrumbs
  end


  class_methods do
    def add_breadcrumb(item, path)
      before_filter do |controller|
        controller.send(:add_breadcrumb, item, path)
      end
    end
  end

  def setup_tasty_breadcrumbs
    @tasty_breadcrumbs = VAlexL::MyBlog::Decorators::Breadcrumbs::Main.new
    @tasty_breadcrumbs_setting = VAlexL::MyBlog::Decorators::Breadcrumbs::Setting.new VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_CONTAINER_TEMPLATE,
                                                                                      VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_SIMPLE_ITEM_TEMPLATE,
                                                                                      VAlexL::MyBlog::Decorators::Breadcrumbs::Printer::DEFAULT_LAST_ITEM_TEMPLATE 
  end
  
  def add_breadcrumb(item, path)
    @tasty_breadcrumbs.add_item(item, path)
  end

  [:container_template, :simple_item_template, :last_item_template].each do |setting_item|
    method_name = "set_#{setting_item}" #set_container_template, set_simple_item_template, set_last_item_template

    define_method method_name do |value|
      @tasty_breadcrumbs_setting.send("#{setting_item}=", value)
    end   
    
    define_singleton_method method_name do |value|
      before_filter do |controller|
        controller.send(method_name, value)
      end
    end
  end


  def display_tasty_breadcrumbs
    @tasty_breadcrumbs.render(@tasty_breadcrumbs_setting)
  end



end
