class Admin::MainController < Admin::BaseController    
  def index
    add_breadcrumb 'Главная', :admin_root_path
  end
end
