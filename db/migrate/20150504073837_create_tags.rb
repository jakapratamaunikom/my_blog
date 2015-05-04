class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :article_id
      t.string :title
      t.string :lang

      t.timestamps null: false
    end
  end
end
