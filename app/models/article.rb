class Article < ActiveRecord::Base
  mount_uploader :image_ru, AvatarUploader
  mount_uploader :image_en, AvatarUploader

  def fully_filled_ru?
    title_ru.present? && content_ru.present? && image_ru.present?
  end

  def fully_filled_en?
    title_en.present? && content_en.present? && image_en.present?
  end
end
