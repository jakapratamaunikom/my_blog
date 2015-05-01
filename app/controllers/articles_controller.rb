class ArticlesController < BaseController

  def index
    @articles = Article.published
  end

  def show
    @article = Article.published.find(params[:id])
    add_tasty_breadcrumb @article.title(current_lang), article_path(@article)
  end

  def preview
    @article = Article.find(params[:id])
    add_tasty_breadcrumb @article.title(current_lang), preview_article_path(@article)

    respond_to do |format|
      format.html { render :show }
    end
  end
end
