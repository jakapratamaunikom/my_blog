class VAlexL::MyBlog::FormObjects::Article
  include Virtus.model
  include ActiveModel::Validations

  attribute :title_ru,   String
  attribute :image_ru,   String
  attribute :content_ru, String
  attribute :title_en,   String
  attribute :image_en,   String
  attribute :content_en, String
    
  attr_reader :article

  validate :should_have_full_content_least_one_laguage

  def self.human_attribute_name(attr, options = {}) #для отображения сообщений валидации
    name   = I18n.t('form_objects.article')[attr]
    name ||= attr
    name
  end


  def initialize(article, attributes={})
    @article = article
    super(attributes)
  end

  def save
    return @article.save if valid?
    false
  end

  private
    def should_have_full_content_least_one_laguage
      return if (title_ru.present? && image_ru.present? && content_ru.present?) || (title_en.present? && image_en.present? && content_en.present?)
      errors.add(:article, :should_have_full_content_least_one_laguage)
    end
end
