module Publishable
  extend ActiveSupport::Concern
  
  def fully_filled?
    title.present? && content.present? && image.present? && image.file.present?
  end

  def toggle_published!
    if published?
      set_unpublished!
    else
      set_published!
    end
  end
  
  def set_unpublished!
    self.published = false 
    save!
  end
  
  def set_published!
    self.published = true and save!
  end


end

