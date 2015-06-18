class Admin::SessionsController < Admin::BaseController
  skip_before_action :authenticate!

  def new
    redirect_to admin_root_path if current_user_admin?
  end

  def check
    @authenticator = VAlexL::MyBlog::Authenticator.new password

    if @authenticator.allowed_access?
      session[:is_admin] = true
      redirect_to back_url
    else
      session[:is_admin] = false
      render :new
    end
  end

  private
    def auth_params
      params.require(:auth).permit(:password, :back_url)
    end

    def password
      auth_params[:password]
    end

    def back_url
      @back_url = auth_params[:back_url].present? ? auth_params[:back_url] : admin_root_path
    end
end
