class ArticlesController < BaseController
  
  skip_before_action :reset_tag_ids, :only => [:index]

  def index
    @filter   = VAlexL::MyBlog::Filters::Article.new  session[:tag_ids]
    @articles = @filter.get_records
  end

  def show
    @article = Article.published.find(params[:id])
    add_tasty_breadcrumb @article.get_content(current_lang).title, article_path(@article)
  end

  def preview
    @article = Article.find(params[:id])
    add_tasty_breadcrumb @article.get_content(current_lang).title, preview_article_path(@article)

    respond_to do |format|
      format.html { render :show }
    end
  end
end
