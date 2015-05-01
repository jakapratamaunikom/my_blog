class PagesController < BaseController
  def about_me
    add_tasty_breadcrumb "О себе", :about_me_path
    
    respond_to do |format|
      format.html 
    end
  end

end
