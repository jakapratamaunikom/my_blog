class ImagesController < Admin::BaseController
  before_action :set_image, only: [:destroy]

  # POST /images
  # POST /images.json
  def create
    @image = image.new(image_params)

    respond_to do |format|
      if @image.save
        format.json { render json: @image, status: :created, location: @image }
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:images).permit(:file)
    end
end
