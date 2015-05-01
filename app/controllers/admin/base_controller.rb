class Admin::BaseController < ApplicationController
  layout 'admin'

  helper_method :lang

  def lang
    params[:lang].present? ? params[:lang].to_sym : :ru 
  end

  def russian_language?
    lank == :ru
  end

  def english_language?
    lank == :en
  end
end
