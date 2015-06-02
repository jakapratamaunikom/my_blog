class RenameWorkContentToWorkInImage < ActiveRecord::Migration
  def change
    rename_column :images, :work_content_id, :work_id
  end
end
