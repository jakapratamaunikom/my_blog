class Comment < ActiveRecord::Base

  belongs_to :article
  belongs_to :parent, class_name: 'Comment', foreign_key: :parent_id

  validates :name, :content, :article, :presence => true
end
