class CreateArticleContents < ActiveRecord::Migration
  def change
    create_table :article_contents do |t|
      t.text :content
      t.string :title
      t.string :image
      t.string :lang

      t.timestamps null: false
    end
  end
end
