class ArticlesController < BaseController

  def index
    @articles = Article.published
  end
end
