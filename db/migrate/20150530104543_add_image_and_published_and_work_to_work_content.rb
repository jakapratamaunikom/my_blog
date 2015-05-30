class AddImageAndPublishedAndWorkToWorkContent < ActiveRecord::Migration
  def change
    add_column :work_contents, :work_id, :integer
    add_column :work_contents, :published, :boolean
    add_column :work_contents, :image, :string
  end
end
