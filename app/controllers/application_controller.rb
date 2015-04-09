class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :reset_breadcrumbs

  def reset_breadcrumbs
    VAlexL::MyBlog::Decorators::Breadcrumbs::Main.reset_items
  end

  def self.add_breadcrumb(item, path)
    before_filter do |controller|
      controller.send(:add_breadcrumb, item, path)
    end
  end
    
  def add_breadcrumb(item, path)
    puts '!!!!!!!!!!!!!!!'
    puts "add_breadcrumb"
    puts '!!!!!!!!!!!!!!!'
    VAlexL::MyBlog::Decorators::Breadcrumbs::Main.add_item(item, path)
  end

end
