class VAlexL::MyBlog::FormObjects::Article
  include Virtus.model
  include ActiveModel::Validations

  attribute :title_ru,   String
  attribute :title_en,   String
  attribute :image_ru,   String
  attribute :image_en,   String
  attribute :content_ru, String
  attribute :content_en, String
  attribute :ru_tags,    String
  attribute :en_tags,    String
    
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
    @ru_tags = @ru_tags.to_s
    @en_tags = @en_tags.to_s
  end

  def is_tag_selected?(tag)
    @ru_tags.split(" ").any? {|id| id.to_i == tag.id} || @en_tags.split(" ").any? {|id| id.to_i == tag.id}
  end

  def save
    @article.title_ru   = title_ru
    @article.content_ru = content_ru
    @article.image_ru   = image_ru
    @article.title_en   = title_en
    @article.content_en = content_en
    @article.image_en   = image_en
    return false unless valid?
    @article.save! and @article.tag_ids = get_tag_ids
    true
  end

  private
    def should_have_title_least_one_languate
      return if title_ru.present? || title_en.present?
      errors.add(:article, :should_have_title_least_one_languate)
    end

    def get_tag_ids
      @ru_tags.split(" ").map(&:to_i) + @en_tags.split(" ").map(&:to_i)
    end
end
