class MainController < BaseController

  def index
    add_tasty_breadcrumb I18n.t("views.header.blog"), :root_path
  end
end
