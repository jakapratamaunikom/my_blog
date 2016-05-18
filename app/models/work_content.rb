class WorkContent < ActiveRecord::Base
  include Localizable
  include Publishable

  scope :published, -> { where(published: true) }
  belongs_to :work
  delegate :image, to: :work, :allow_nil => true
  validates  :work, presence: true

end
