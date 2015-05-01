class ArticlesController < BaseController

  def index
    @articles = Article.published
  end

  def show
    @article = Article.find(params[:id])
    add_tasty_breadcrumb @article.title(current_lang), article_path(@article)
  end
end
