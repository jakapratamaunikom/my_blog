class Admin::SettingsController < Admin::BaseController
  add_tasty_breadcrumb 'Админка', :admin_root_path

  def about_me
    add_tasty_breadcrumb "Настройка \"О себе (#{lang.upcase})\"", :abount_me_admin_setting_root_path
    @about_me = VAlexL::MyBlog::PagesInfo::AboutMe.new lang
    
    respond_to do |format|
      format.html 
    end
  end

  def portfolio
    add_tasty_breadcrumb "Настройка \"Портфолио (#{lang.upcase})\"", :portfolio_admin_setting_root_path
    
    respond_to do |format|
      format.html 
    end
  end
end
