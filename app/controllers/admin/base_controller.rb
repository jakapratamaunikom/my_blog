class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authenticate!

  add_tasty_breadcrumb 'Админка', :admin_root_path

  def authenticate!
    redirect_to admin_sign_in_path(back_url: get_original_url) unless current_user_admin?
    true
  end

  def get_original_url
    @get_original_url ||= "http://#{request.host_with_port}#{request.fullpath}"
  end
end
