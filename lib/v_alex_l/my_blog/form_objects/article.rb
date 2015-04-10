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
    @article.save
  end

  private
    def should_have_full_content_least_one_laguage
      if title_ru.blank? || image_ru.blank? || content_ru.blank? || title_en.blank? || image_en.blank? || content_en.blank?
        errors.add(:self, :should_have_full_content_least_one_laguage)
      end
    end
end
