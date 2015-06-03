class VAlexL::MyBlog::FormObjects::Work
  include Virtus.model
  include ActiveModel::Validations

  delegate :russian_content, :english_content, to: :@work
  delegate :to_key, :persisted?, :to_model, to: :@work
  delegate :title=, :content=, :image=, :published=, to: :russian_content, prefix: 'ru'
  delegate :title,  :content,  :image,  :published,  to: :russian_content, prefix: 'ru'
  delegate :title=, :content=, :image=, :published=, to: :english_content, prefix: 'en'
  delegate :title,  :content,  :image,  :published,  to: :english_content, prefix: 'en'

    
  attr_reader   :work

  validates :ru_content, presence: true, if: Proc.new {|af| af.ru_title.present?}
  validates :en_content, presence: true, if: Proc.new {|af| af.en_title.present?}

  validate :should_have_title_least_one_language

  def self.human_attribute_name(attr, options = {}) #для отображения сообщений валидации
    name   = I18n.t('form_objects.work')[attr]
    name ||= attr
    name
  end

  def initialize(work, attributes={})
    @work = work

    attributes = {} if attributes.blank?

    attributes.each do |method, value|
      self.send("#{method}=", value)
    end

    super(attributes)
  end

  def image_ids=(ids)
    @image_ids = ids
  end

  def image_ids
    @image_ids
  end

  def images
    Image.where(id: image_ids)
  end

  def save
    return false unless valid?
    @work.save! and append_images
  end

  private
    def should_have_title_least_one_language
      return if ru_title.present? || en_title.present?
      errors.add(:work, :should_have_title_least_one_language)
    end

    def append_images
      Image.where(id: image_ids).update_all work_id: @work.id
      true
    end
    
end
