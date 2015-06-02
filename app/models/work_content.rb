class WorkContent < ActiveRecord::Base
  include Localizable

  mount_uploader :image, AvatarUploader
  
  scope :published, -> { where(published: true) }
  
  belongs_to :work
  validates  :work, presence: true

end
