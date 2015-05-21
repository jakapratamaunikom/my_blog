class ArticleContent < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  
  scope :published, -> { where(published: true) }
  scope :ru, -> {where(lang: :ru)}
  scope :en, -> {where(lang: :en)}

  belongs_to :article
  has_and_belongs_to_many :tags

  validates :article, presence: true
  validates :lang, inclusion: Article::LANGUAGES

  def fully_filled?
    title.present? && content.present? && image.present? && image.file.present?
  end

  def russian?
    lang.to_s == 'ru'
  end

  def english?
    lang.to_s == 'en'
  end

  def toggle_published!
    if published?
      set_unpublished!
    else
      set_published!
    end
  end
  
  def set_unpublished!
    self.published = false 
    save!
  end
  
  def set_published!
    self.published = true and save!
  end
end
