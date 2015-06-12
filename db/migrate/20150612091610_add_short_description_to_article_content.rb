class AddShortDescriptionToArticleContent < ActiveRecord::Migration
  def change
    add_column :article_contents, :short_description, :text
  end
end
