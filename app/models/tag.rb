class Tag < ActiveRecord::Base
  LANGS = %w(ru en)
  scope :ru, -> {where(lang: :ru)}
  scope :en, -> {where(lang: :en)}

  belongs_to :article

  validates :title, :article, presence: true
  validates :lang, inclusion: LANGS
end
