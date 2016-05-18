class ImageTransferFromWorkContentToWork < ActiveRecord::Migration
  def change
    WorkContent.where.not(image: nil).find_each do |record|
      if Work.exists?(record.work_id)
        work = Work.find(record.work_id);
        work.image = File.new(File.join(Rails.root, '/public' + record.image.url))
        work.save!
        work.image.recreate_versions!
      end
    end
  end
end
