class Tag < ActiveRecord::Base
  scope :ru, -> {where(lang: :ru)}
  scope :en, -> {where(lang: :en)}

  has_and_belongs_to_many :article_contents
  has_many :articles, through: :article_contents

  validates :title, presence: true
  validates :lang, inclusion: Article::LANGUAGES

  def to_s
    title
  end
end
