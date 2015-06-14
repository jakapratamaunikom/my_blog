class WorkContent < ActiveRecord::Base
  include Localizable
  include Publishable

  mount_uploader :image, AvatarUploader
  
  scope :published, -> { where(published: true) }
  
  belongs_to :work
  validates  :work, presence: true

end
