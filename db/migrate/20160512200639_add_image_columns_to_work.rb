class AddImageColumnsToWork < ActiveRecord::Migration
  def change
    add_column :works, :image, :string
  end
end
