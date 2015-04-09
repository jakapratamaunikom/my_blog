class MainController < ApplicationController

  def index
    add_breadcrumb 'Главная', :root_path
  end
end
