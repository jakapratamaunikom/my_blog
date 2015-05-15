class Tag < ActiveRecord::Base
  scope :ru, -> {where(lang: :ru)}
  scope :en, -> {where(lang: :en)}

  has_and_belongs_to_many :articles

  validates :title, presence: true
  validates :lang, inclusion: Article::LANGUAGES

  def to_s
    title
  end
end
