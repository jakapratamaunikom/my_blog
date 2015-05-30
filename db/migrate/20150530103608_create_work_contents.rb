class CreateWorkContents < ActiveRecord::Migration
  def change
    create_table :work_contents do |t|
      t.string :title
      t.string :lang
      t.text :content

      t.timestamps null: false
    end
  end
end
