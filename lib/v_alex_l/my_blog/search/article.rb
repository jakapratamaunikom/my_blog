class VAlexL::MyBlog::Search::Article

  def initialize(query_search)
    @query_search = query_search
  end

  def search
    if @query_search == nil then
      @articles = ::Article.all
    else
      @articles = ::Article.joins(:article_contents).where("title LIKE ?", "%#{@query_search}%")
    end
  end
end
