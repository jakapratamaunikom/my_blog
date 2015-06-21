class InitRemovedFalseToWorkAndArticle < ActiveRecord::Migration
  def change
    Article.update_all removed: false
    Work.update_all removed: false
  end
end
