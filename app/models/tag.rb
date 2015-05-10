class Tag < ActiveRecord::Base
  LANGS = %w(ru en)
  scope :ru, -> {where(lang: :ru)}
  scope :en, -> {where(lang: :en)}

  validates :title, presence: true
  validates :lang, inclusion: LANGS

  def to_s
    title
  end
end
