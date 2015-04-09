class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :reset_breadcrumbs

  def reset_breadcrumbs
    VAlexL::MyBlog::Decorators::Breadcrumbs::Main.reset_items
  end


  [:container_template, :simple_item_template, :last_item_template].each do |setting_item|
    method_name = "set_#{setting_item}" #set_container_template, set_simple_item_template, set_last_item_template
    define_method method_name do |value|
      VAlexL::MyBlog::Decorators::Breadcrumbs::Main.setting.send("#{setting_item}=", value)
    end   
    
    define_singleton_method method_name do |value|
      before_filter do |controller|
        controller.send(method_name, value)
      end
    end
  end

  def self.add_breadcrumb(item, path)
    before_filter do |controller|
      controller.send(:add_breadcrumb, item, path)
    end
  end
    
  def add_breadcrumb(item, path)
    VAlexL::MyBlog::Decorators::Breadcrumbs::Main.add_item(item, path)
  end

end
