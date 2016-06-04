class RegistrationsController < Devise::RegistrationsController
  
  before_action :init_language
  before_action do
    set_container_template "div.tales-breadcrumb"
    set_simple_item_template   "a.breadcrumb-item"
    set_last_item_template "a"
    add_tasty_breadcrumb I18n.t("views.header.blog"), :root_path
    add_tasty_breadcrumb I18n.t("views.header.sign_up"), :new_user_registration_path
  end

  before_action :init_tag_ids
  before_action :reset_tag_ids
  
  def create
    params[:user][:password] = 'password'
    params[:user][:password_confirmation] = 'password'
    super
  end  

  def check_registration
    @user = User.where("email LIKE ?", "#{params[:email]}")

    respond_to do |format|
      format.json { render json: @user }
    end
  end
  
  private
    def init_language
      I18n.locale = current_lang
    end
end 
