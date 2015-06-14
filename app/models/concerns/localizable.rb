module Localizable
  extend ActiveSupport::Concern
  
  module ClassMethods
    ::LANGUAGES = %w(ru en)
  end

  included do
    scope :ru, -> {where(lang: :ru)}
    scope :en, -> {where(lang: :en)}

    validates :lang, inclusion: LANGUAGES
  end
  
  def russian?
    lang.to_s == 'ru'
  end

  def english?
    lang.to_s == 'en'
  end

end

