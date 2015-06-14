class Pride < ActiveRecord::Base
  include Localizable
  
  belongs_to :objective, polymorphic: true
end
