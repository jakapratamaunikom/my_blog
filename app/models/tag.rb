class Tag < ActiveRecord::Base
  scope :ru, -> { joins(:article_contents).where(article_contents: {lang: :ru, published: true}).uniq }
  scope :en, -> { joins(:article_contents).where(article_contents: {lang: :en, published: true}).uniq }

  has_and_belongs_to_many :article_contents
  has_many :articles, through: :article_contents

  validates :title, presence: true

  def to_s
    title
  end
end
