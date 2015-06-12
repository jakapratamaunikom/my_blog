class VAlexL::MyBlog::FormObjects::Article
  include Virtus.model
  include ActiveModel::Validations

  delegate :russian_content, :english_content, to: :@article
  delegate :to_key, :persisted?, :to_model, to: :@article
  delegate :title=, :content=, :image=, :published=, :short_description=, to: :russian_content, prefix: 'ru'
  delegate :title,  :content,  :image,  :published,  :short_description,  to: :russian_content, prefix: 'ru'
  delegate :title=, :content=, :image=, :published=, :short_description=, to: :english_content, prefix: 'en'
  delegate :title,  :content,  :image,  :published,  :short_description,  to: :english_content, prefix: 'en'

  attribute :ru_tags,    Array
  attribute :en_tags,    Array
    
  attr_reader   :article
  attr_accessor :ru_tags, :en_tags

  validates :ru_content, :ru_short_description, presence: true, if: Proc.new {|af| af.ru_title.present?}
  validates :en_content, :en_short_description, presence: true, if: Proc.new {|af| af.en_title.present?}

  validate :should_have_title_least_one_language

  def self.human_attribute_name(attr, options = {}) #для отображения сообщений валидации
    name   = I18n.t('form_objects.article')[attr]
    name ||= attr
    name
  end

  def initialize(article, attributes={})
    @article = article

    if attributes.blank?
      attributes = {}
      attributes.merge! ru_tags: russian_content.tags.map(&:id)
      attributes.merge! en_tags: english_content.tags.map(&:id)
    end

    @ru_tags = attributes.delete(:ru_tags).to_a
    @en_tags = attributes.delete(:en_tags).to_a

    attributes.each do |method, value|
      self.send("#{method}=", value)
    end

    super(attributes)
  end

  def is_tag_selected?(tag, lang)
    eval("@#{lang}_tags").any? {|id| id.to_i == tag.id}
  end

  def save
    return false unless valid?
    @article.save! and mark_article_by_tags!
    true
  end

  private
    def should_have_title_least_one_language
      return if ru_title.present? || en_title.present?
      errors.add(:article, :should_have_title_least_one_language)
    end
    
    def mark_article_by_tags!
      russian_content.tag_ids = @ru_tags
      english_content.tag_ids = @en_tags
      true
    end

    def get_tag_ids
      @ru_tags + @en_tags
    end
end
