class AddArticleToArticleContents < ActiveRecord::Migration
  def change
    add_column :article_contents, :article_id, :integer
  end
end
