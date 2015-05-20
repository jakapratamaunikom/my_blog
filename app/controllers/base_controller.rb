class BaseController < ApplicationController
  before_action do
    set_container_template "div.tales-breadcrumb"
    set_simple_item_template   "a.breadcrumb-item"
    set_last_item_template "a"

    add_tasty_breadcrumb I18n.t("views.header.blog"), :root_path
  end

  before_action :reset_tag_ids

  helper_method :current_lang

  def current_lang
    :ru
  end

  private
    def reset_tag_ids
      session[:tag_ids] = []
    end

  
end