class ArticlesController < BaseController

  def index
    add_tasty_breadcrumb I18n.t("views.header.blog"), :root_path
    @articles = Article.published
  end
end
