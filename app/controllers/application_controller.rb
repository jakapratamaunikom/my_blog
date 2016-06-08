class ApplicationController < ActionController::Base
  include TastyBreadcrumbs::ActionController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_admin?
  helper_method :current_lang
  
  def current_user_admin?
    session[:is_admin]
  end

  def current_lang
    params[:lang].present? ? params[:lang].to_sym : :ru 
  end

  def russian_language?
    current_lang == :ru
  end

  def english_language?
    current_lang == :en
  end

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in)        << :username
      devise_parameter_sanitizer.for(:sign_up)        << :username
      devise_parameter_sanitizer.for(:account_update) << :username
    end

  private
    def set_language(value)
      session[:current_lang] = value
      reset_tag_ids
    end

    def init_tag_ids
      session[:tag_ids] = [] if session[:tag_ids].nil?
    end
      
    def reset_tag_ids
      session[:tag_ids] = []
    end

    def default_url_options
      if current_lang.present?
      { :lang => current_lang }.merge(super)
      else
        super
      end
    end

end
