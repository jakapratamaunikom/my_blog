class RemoveImageFromWorkContent < ActiveRecord::Migration
  def change
    remove_column :work_contents, :image, :string
  end
end
