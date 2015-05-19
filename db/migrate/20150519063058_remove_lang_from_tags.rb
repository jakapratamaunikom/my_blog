class RemoveLangFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :lang, :string
  end
end
