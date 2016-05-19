class ImageTransferFromArticleContentToArticle < ActiveRecord::Migration
  def change
    
    ArticleContent.where.not(image: nil).find_each do |record|
      if Article.exists?(record.article_id)
        article = Article.find(record.article_id);
        article.image = File.new(File.join(Rails.root, '/public' + record.image.url))
        article.save!
        article.image.recreate_versions!
      end
    end
  end
end
