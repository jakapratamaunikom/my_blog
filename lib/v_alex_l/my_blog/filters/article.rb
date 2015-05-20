class VAlexL::MyBlog::Filters::Article

  def initialize(tag_ids)
    @tag_ids = tag_ids.to_a
  end

  def get_records
    @get_records = ::Article.published
    @get_records = @get_records.joins(:tags).where(tags: {id: @tag_ids}) if @tag_ids.present?
    @get_records.uniq
  end
end

