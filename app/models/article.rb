class Article < ActiveRecord::Base
  validates :title, :image_path, :content, presence: true

  before_save :set_default_lang
  
  private
    def set_default_lang
      self.lang = :ru unless self.lang.present?
      true
    end
end
