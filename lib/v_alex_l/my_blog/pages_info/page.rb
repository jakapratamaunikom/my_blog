class VAlexL::MyBlog::PagesInfo::Page
  include Virtus.model
  attribute :title,   String
  attribute :image,   String
  attribute :content, String

  def get_data
    { title: title, content: content, image: image }
  end
end
