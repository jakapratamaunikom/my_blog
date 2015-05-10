class Tag < ActiveRecord::Base
  LANGS = %w(ru en)
  scope :ru, -> {where(lang: :ru)}
  scope :en, -> {where(lang: :en)}

  has_and_belongs_to_many :articles

  validates :title, presence: true
  validates :lang, inclusion: LANGS

  def to_s
    title
  end
end
