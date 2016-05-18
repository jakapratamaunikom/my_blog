class RemoveImageFromArticleContent < ActiveRecord::Migration
  def change
    remove_column :article_contents, :image, :string
  end
end
