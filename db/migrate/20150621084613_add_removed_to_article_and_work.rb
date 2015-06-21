class AddRemovedToArticleAndWork < ActiveRecord::Migration
  def change
    add_column :articles, :removed, :boolean, default: false
    add_column :works,    :removed, :boolean, default: false
  end
end
