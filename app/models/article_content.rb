class ArticleContent < ActiveRecord::Base
  mount_uploader :image, AvatarUploader

  belongs_to :article

  validates :title, :content, :article, presence: true
  validates :lang, inclusion: Article::LANGUAGES

end
