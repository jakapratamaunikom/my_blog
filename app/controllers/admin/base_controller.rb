class Admin::BaseController < ApplicationController
  layout 'admin'

  helper_method :current_lang

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
end
