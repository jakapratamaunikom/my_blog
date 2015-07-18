class Article < ActiveRecord::Base
  LANGUAGES = %w(ru en)

  default_scope { where(removed: false).order(:created_at => :desc) }

  scope :published, ->(lang) { joins(:article_contents).merge(ArticleContent.send(lang).published) }
  
  has_many :comments
  has_many :article_contents

  has_many :tags, through: :article_contents
  has_many :ru_tags, -> { ru }, class_name: 'Tag'
  has_many :en_tags, -> { en }, class_name: 'Tag'

  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :article_contents
    

  def remove!
    self.removed = true and save!
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
