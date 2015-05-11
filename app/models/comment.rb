class Comment < ActiveRecord::Base

  ORIGIN = 'origin'
  REPLY  = 'reply'

  belongs_to :article
  belongs_to :parent,   class_name: 'Comment', foreign_key: :parent_id
  has_many   :children, class_name: 'Comment', foreign_key: :parent_id

  validates :name, :content, :article, :presence => true

  def kind
    return ORIGIN if parent.blank?
    REPLY
  end

  def nested_comments
    children.inject([]) do |res, child|
      res.push(child)
      res += child.nested_comments
    end
  end
end
