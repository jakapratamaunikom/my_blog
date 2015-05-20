class VAlexL::MyBlog::Filters::Article

  def initialize(tag_ids)
    @tag_ids = tag_ids
  end

  def get_records
    @get_records = ::Article.published
    @get_records.joins(:tags).where(tags: {id: @tag_ids}).uniq
  end
end

