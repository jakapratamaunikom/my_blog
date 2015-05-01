class Admin::SettingsController < Admin::BaseController
  add_tasty_breadcrumb 'Админка', :admin_root_path

  def portfolio
    add_tasty_breadcrumb "Настройка \"Портфолио (#{lang.upcase})\"", :portfolio_admin_setting_root_path
    
    respond_to do |format|
      format.html 
    end
  end
end
