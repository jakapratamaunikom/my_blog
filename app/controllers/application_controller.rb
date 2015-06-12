class ApplicationController < ActionController::Base
  include TastyBreadcrumbs::ActionController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_lang
    return :ru if session[:current_lang].blank?
    session[:current_lang]
  end

  private
    def set_language(value)
      session[:current_lang] = value
    end
end
