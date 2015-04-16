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

  validates :content_ru, presence: true, if: Proc.new {|a| a.title_ru.present?}
  validates :content_en, presence: true, if: Proc.new {|a| a.title_en.present?}

  validate :should_have_title_least_one_languate

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
    @article.title_ru   = title_ru
    @article.content_ru = content_ru
    @article.image_ru   = image_ru
    @article.title_en   = title_en
    @article.content_en = content_en
    @article.image_en   = image_en
    return @article.save! if valid?
    false
  end

  private
    def should_have_title_least_one_languate
      return if title_ru.present? || title_en.present?
      errors.add(:article, :should_have_title_least_one_languate)
    end


end
