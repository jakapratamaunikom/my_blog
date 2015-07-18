class Work < ActiveRecord::Base
  LANGUAGES = %w(ru en)

  default_scope { where(removed: false).order(:created_at => :desc) }
  scope :published, ->(lang) { joins(:work_contents).merge(WorkContent.send(lang).published) }
  
  has_many :work_contents
  has_many :images
  
  accepts_nested_attributes_for :work_contents

  def remove!
    self.removed = true and save!
  end

  def get_content(lang)
    check_given_lang!(lang)
    return russian_content if lang.to_s == 'ru'
    english_content
  end

  def russian_content
    @russian_content   = work_contents.find {|work_content| work_content.russian?} 
    @russian_content ||= work_contents.build(lang: :ru, work: self)
  end

  def english_content
    @english_content   = work_contents.find {|work_content| work_content.english?} 
    @english_content ||= work_contents.build(lang: :en, work: self)
  end

  private
    def check_given_lang!(lang)
      raise "#{lang} - is incorrect language" unless LANGUAGES.include?(lang.to_s)
    end

end
