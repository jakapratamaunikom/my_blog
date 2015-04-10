class MainController < ApplicationController

  def index
    add_tasty_breadcrumb 'Главная', :root_path
  end
end
