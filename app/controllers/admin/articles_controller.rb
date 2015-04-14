class Admin::ArticlesController < Admin::BaseController
  add_tasty_breadcrumb 'Админка', :admin_root_path
  add_tasty_breadcrumb 'Статьи',  :admin_articles_path

  def index
  end

  def new
    add_tasty_breadcrumb 'Создание новой статьи', :new_admin_article_path
    @article = Article.new
  end

  def show
    add_tasty_breadcrumb 'Моя типо первая статья', admin_article_path(1)
  end

  def edit
    add_tasty_breadcrumb 'Моя типо первая статья', admin_article_path(1)
    add_tasty_breadcrumb 'Моя типо первая статья', edit_admin_article_path(1)

  end

end
