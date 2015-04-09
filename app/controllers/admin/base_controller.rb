class Admin::BaseController < ApplicationController
  layout 'admin'

  def self.add_breadcrumb(item, path, html_options={})
    VAlexL::MyBlog::Decorators::Breadcrumbs::Main.add_item(item, path)
  end

  def add_breadcrumb(item, path, html_options={})
    VAlexL::MyBlog::Decorators::Breadcrumbs::Main.add_item(item, path)
  end
end
