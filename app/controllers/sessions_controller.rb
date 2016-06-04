class SessionsController < Devise::SessionsController
  
  before_action :init_language
  before_action do
    set_container_template "div.tales-breadcrumb"
    set_simple_item_template   "a.breadcrumb-item"
    set_last_item_template "a"
    add_tasty_breadcrumb I18n.t("views.header.blog"), :root_path
    add_tasty_breadcrumb I18n.t("views.header.sign_in"), :new_user_session_path
  end

  before_action :init_tag_ids
  before_action :reset_tag_ids

  private
    def init_language
      I18n.locale = current_lang
    end
end    
