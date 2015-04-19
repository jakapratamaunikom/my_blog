class AddPublishedToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :published_ru, :boolean
    add_column :articles, :published_en, :boolean
  end
end
