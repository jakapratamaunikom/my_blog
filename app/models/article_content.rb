class ArticleContent < ActiveRecord::Base
  mount_uploader :image, AvatarUploader

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

end
