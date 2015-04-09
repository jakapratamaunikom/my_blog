class Admin::MainController < Admin::BaseController    
  set_container_template "ul.wow.yes.of-course"
  
  def index
    add_breadcrumb 'Главная', :admin_root_path
  end
end
