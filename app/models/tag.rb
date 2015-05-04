class Tag < ActiveRecord::Base
  belongs_to :article

  validates :title, :lang, :article, presence: true
end
