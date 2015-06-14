class PagesController < BaseController
  def about_me
    add_tasty_breadcrumb I18n.t("views.pages.about_me"), :about_me_path
    
    respond_to do |format|
      format.html 
    end
  end

end
