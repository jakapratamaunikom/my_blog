class ArticleContent < ActiveRecord::Base
  mount_uploader :image, AvatarUploader

  belongs_to :article

  validates :title, :content, :article, presence: true
  validates :lang, inclusion: Article::LANGUAGES

  def title=(value)
    super
  end

  def russian?
    lang.to_s == 'ru'
  end

  def english?
    lang.to_s == 'en'
  end

end
