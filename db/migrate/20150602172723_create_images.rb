class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file
      t.integer :work_content_id

      t.timestamps null: false
    end
  end
end
