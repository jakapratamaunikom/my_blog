class Admin::ArticlesController < Admin::BaseController
  add_breadcrumb 'Админка', :admin_root_path
  add_breadcrumb 'Статьи',  :admin_articles_path

  def index
  end

  def new
    add_breadcrumb 'Создание новой статьи', :new_admin_article_path
  end

end
