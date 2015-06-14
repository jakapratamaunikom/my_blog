class Admin::PridesController < Admin::BaseController
  add_tasty_breadcrumb 'Моя гордость',  :admin_pride_path

  def show
    @pride_form = VAlexL::MyBlog::FormObjects::Pride.new 
  end

  def create
    @pride_form = VAlexL::MyBlog::FormObjects::Pride.new 

    respond_to do |format|
      if @pride_form.apply!(pride_params)
        format.html { redirect_to admin_pride_path, notice: 'Йо! Я горжусь этой гордостью!' }
        format.json { render :show, status: :ok, location: @pride_form.work }
      else
        format.html { render :show }
        format.json { render json: @pride_form.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def pride_params
      params.require(:pride).permit(:ru => [], :en => [],)
                                      
    end
end
