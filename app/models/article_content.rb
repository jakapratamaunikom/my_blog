class ArticleContent < ActiveRecord::Base
  include Localizable
  include Publishable

  mount_uploader :image, AvatarUploader
  
  scope :published, -> { where(published: true) }
  
  belongs_to :article
  has_and_belongs_to_many :tags

  validates :article, presence: true

end
