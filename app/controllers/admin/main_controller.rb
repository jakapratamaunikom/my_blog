class Admin::MainController < Admin::BaseController    
  
  def index
    set_container_template "ul.wow.yes.of-course"
    add_tasty_breadcrumb 'Главная', :admin_root_path
  end
end
