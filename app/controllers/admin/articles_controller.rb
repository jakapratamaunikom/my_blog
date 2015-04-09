class Admin::ArticlesController < Admin::BaseController
  add_breadcrumb 'Админка', :admin_root_path
  add_breadcrumb 'Статьи',  :admin_articles_path

  def index
  end

  def new
    add_breadcrumb 'Создание новой статьи', :new_admin_article_path
  end

  def show
    add_breadcrumb 'Моя типо первая статья', :new_admin_article_path
  end

  def edit
    add_breadcrumb 'Моя типо первая статья', :some_path
    add_breadcrumb 'Моя типо первая статья', :new_admin_article_path

  end

end
