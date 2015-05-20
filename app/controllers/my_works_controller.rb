class MyWorksController < BaseController

  add_tasty_breadcrumb I18n.t("views.header.my_works"), :my_works_path

  def index
  end

  def show
    add_tasty_breadcrumb 'Какой-то проект', '#'
  end

  def preview
  end
end
