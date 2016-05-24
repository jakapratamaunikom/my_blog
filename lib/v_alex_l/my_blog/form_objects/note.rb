class VAlexL::MyBlog::FormObjects::Note
  include Virtus.model
  include ActiveModel::Validations

  attribute :title, String
  attribute :description, String
  delegate :to_key, :persisted?, :to_model, to: :@note

  attr_reader :note

  validates :title, :description, :presence => true

  def initialize(note, attributes = {})
    @note = note
    
    if attributes.blank?
      attributes = {}
      attributes.merge! title: note.title
      attributes.merge! description: note.description
    else
       @note.title = attributes[:title]
       @note.description = attributes[:description]
    end
    @title  = attributes[:title]
    @description = attributes[:description]
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    if @note.new_record?
      @note.update(attributes)
    else
      @note.save
      # Note.create!(title: title, description: description)
    end  
  end
end  
