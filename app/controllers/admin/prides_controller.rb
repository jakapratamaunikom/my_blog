class Admin::PridesController < Admin::BaseController
  add_tasty_breadcrumb 'Моя гордость',  :edit_admin_pride_path

  def show
    # @pride_form = VAlexL::MyBlog::FormObjects::Pride.new 
  end

  def update
    # @pride_form = VAlexL::MyBlog::FormObjects::Pride.new pride_params

    # respond_to do |format|
    #   if @pride_form.save
    #     format.html { redirect_to edit_admin_pride_path, notice: 'Йо! Я горжусь этой гордостью!' }
    #     format.json { render :show, status: :ok, location: @pride_form.work }
    #   else
    #     format.html { render :show }
    #     format.json { render json: @pride_form.errors, status: :unprocessable_entity }
    #   end
    # end
  end


  private
    def pride_params
      params.require(:work).permit(:ru_title, :ru_content, :ru_image,
                                   :en_title, :en_content, :en_image,
                                   :image_ids => [],
                                  )
                                      
    end
end
