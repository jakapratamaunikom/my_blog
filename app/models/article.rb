class Article < ActiveRecord::Base
  LANGUAGES = %w(ru en)
  scope :published, -> {where("articles.published_ru = ? OR articles.published_en = ?", true, true)}
  
  has_many :comments
  has_many :article_contents

  has_many :tags, through: :article_contents
  has_many :ru_tags, -> { ru }, class_name: 'Tag'
  has_many :en_tags, -> { en }, class_name: 'Tag'

  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :article_contents

  LANGUAGES.each do |lang|
    define_method "fully_filled_#{lang}?" do
      title(lang).present? && content(lang).present? && image(lang).present?
    end
  end

  def published?(lang)
    get_content(lang).published?
  end

  def set_published!(lang)
    article_content = get_content(lang)
    article_content.published = true and article_content.save!
  end

  def toggle_published!(lang)
    if published?(lang)
      set_unpublished!(lang)
    else
      set_published!(lang)
    end
  end

  def set_unpublished!(lang)
    article_content = get_content(lang)
    article_content.published = false 
    article_content.save!
  end
  
  def title(lang)
    get_content(lang).title
  end

  def content(lang)
    get_content(lang).content
  end

  def image(lang)
    get_content(lang).image
  end

  def get_tags(lang)
    get_content(lang).tags
  end

  def get_content(lang)
    check_given_lang!(lang)
    return russian_content if lang.to_s == 'ru'
    english_content
  end

  def russian_content
    @russian_content   = article_contents.find {|article_content| article_content.russian?} 
    @russian_content ||= article_contents.build(lang: :ru, article: self)
  end

  def english_content
    @english_content   = article_contents.find {|article_content| article_content.english?} 
    @english_content ||= article_contents.build(lang: :en, article: self)
  end

  def count_comments
    comments.count
  end

  private
    def check_given_lang!(lang)
      raise "#{lang} - is incorrect language" unless LANGUAGES.include?(lang.to_s)
    end

end
