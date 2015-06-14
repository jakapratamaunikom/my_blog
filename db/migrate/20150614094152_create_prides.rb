class CreatePrides < ActiveRecord::Migration
  def change
    create_table :prides do |t|
      t.references :objective, polymorphic: true, index: true
      t.string :lang

      t.timestamps null: false
    end
  end
end
