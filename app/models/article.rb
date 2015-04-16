class Article < ActiveRecord::Base
  mount_uploader :image_ru, AvatarUploader
  # mount_uploader :image_en, AvatarUploader

end
