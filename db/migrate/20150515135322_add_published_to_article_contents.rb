class AddPublishedToArticleContents < ActiveRecord::Migration
  def change
    add_column :article_contents, :published, :boolean
  end
end
