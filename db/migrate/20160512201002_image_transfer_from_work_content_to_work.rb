class ImageTransferFromWorkContentToWork < ActiveRecord::Migration
  def change
    WorkContent.where.not(image: nil).find_each do |record|
      if Work.exists?(record.article_id)
        article = Work.find(record.article_id);
        article.image = File.new(File.join(Rails.root, '/public' + record.image.url))
        article.save!
        article.image.recreate_versions!
      end
    end
  end
end
