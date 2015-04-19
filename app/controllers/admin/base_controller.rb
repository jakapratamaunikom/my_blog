class Admin::BaseController < ApplicationController
  layout 'admin'

  helper_method :lang

  def lang
    params[:lang].present? ? params[:lang].to_sym : :ru 
  end

end
