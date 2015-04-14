class AddTitleContentAndImageToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :title_ru, :string
    add_column :articles, :title_en, :string
    add_column :articles, :content_ru, :text
    add_column :articles, :content_en, :text
    add_column :articles, :image_ru, :string
    add_column :articles, :image_en, :string

    remove_column :articles, :title, :string
    remove_column :articles, :content, :text
    remove_column :articles, :image_path, :string
    remove_column :articles, :lang, :string

  end
end
