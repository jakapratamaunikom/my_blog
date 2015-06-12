class VAlexL::MyBlog::Filters::Article

  def initialize(tag_ids, lang)
    @tag_ids = tag_ids.to_a
    @lang    = lang
  end

  def get_records
    @articles = ::Article.joins(:article_contents).merge(ArticleContent.send(@lang).published)

    if @tag_ids.present?
      @articles = @articles.select do |article| 
        article.article_contents.published.any?{|ac| @tag_ids.all?{|t_id| ac.tag_ids.include?(t_id)}}
      end
    end
    ::Article.where(id: @articles.map(&:id))
  end
end

