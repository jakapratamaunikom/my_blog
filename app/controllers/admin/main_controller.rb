class Admin::MainController < Admin::BaseController    
  def index
    add_tasty_breadcrumb 'Главная', :admin_root_path
  end
end
