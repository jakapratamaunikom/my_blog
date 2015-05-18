class RemoveTitleContentLanguageAndImageFromArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :title_ru, :string
    remove_column :articles, :title_en, :string
    remove_column :articles, :content_ru, :string
    remove_column :articles, :content_en, :string
    remove_column :articles, :image_ru, :string
    remove_column :articles, :image_en, :string
    remove_column :articles, :published_ru, :string
    remove_column :articles, :published_en, :string
  end
end
