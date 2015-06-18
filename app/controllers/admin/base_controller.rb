class Admin::BaseController < ApplicationController
  layout 'admin'

  helper_method :current_lang
  before_action :authenticate!

  add_tasty_breadcrumb 'Админка', :admin_root_path

  def current_lang
    params[:lang].present? ? params[:lang].to_sym : :ru 
  end

  def russian_language?
    current_lang == :ru
  end

  def english_language?
    current_lang == :en
  end

  def authenticate!
    redirect_to admin_sign_in_path(back_url: get_original_url) unless current_user_admin?
    true
  end

  def get_original_url
    @get_original_url ||= "http://#{request.host_with_port}#{request.fullpath}"
  end
end
