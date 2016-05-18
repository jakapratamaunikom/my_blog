class ArticleContent < ActiveRecord::Base
  include Localizable
  include Publishable

  scope :published, -> { where(published: true) }
  
  belongs_to :article
  delegate :image, to: :article, :allow_nil => true
  has_and_belongs_to_many :tags

  validates :article, presence: true
end
