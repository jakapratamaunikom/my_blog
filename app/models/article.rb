class Article < ActiveRecord::Base
  LANGUAGES = %w(ru en)
  scope :published, -> {where("articles.published_ru = ? OR articles.published_en = ?", true, true)}
  mount_uploader :image_ru, AvatarUploader
  mount_uploader :image_en, AvatarUploader

  LANGUAGES.each do |lang|
    define_method "fully_filled_#{lang}?" do
      title(lang).present? && content(lang).present? && image(lang).present?
    end
  end

  def published?(lang)
    check_given_lang!(lang)
    send("published_#{lang}?")    
  end

  def set_published!(lang)
    check_given_lang!(lang)
    send("published_#{lang}=", true)
    save!
  end

  def toggle_published!(lang)
    if published?(lang)
      set_unpublished!(lang)
    else
      set_published!(lang)
    end
  end

  def set_unpublished!(lang)
    check_given_lang!(lang)
    send("published_#{lang}=", false)
    save!
  end
    
  def title(lang)
    check_given_lang!(lang)
    send("title_#{lang}")
  end

  def content(lang)
    check_given_lang!(lang)
    send("content_#{lang}")
  end

  def image(lang)
    check_given_lang!(lang)
    send("image_#{lang}")
  end

  private
    def check_given_lang!(lang)
      raise "#{lang} - is incorrect language" unless LANGUAGES.include?(lang.to_s)
    end

end
