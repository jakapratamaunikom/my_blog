class CreateArticleContentsTags < ActiveRecord::Migration
  def change
    create_table :article_contents_tags do |t|
      t.integer :article_content_id
      t.integer :tag_id
    end
  end
end
