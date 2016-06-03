module ApplicationHelper

  def get_page_title
    if current_controller?('admin/main')
      'Админка'
    elsif current_controller?('admin/articles') && params[:action] == 'index'
      'Статьи'
    elsif current_controller?('admin/articles') && ['new', 'create'].include?(params[:action])
      'Создание новой статьи'
    elsif current_controller?('admin/articles') && ['edit', 'update'].include?(params[:action])
      'Редактирование статьи'
    elsif current_controller?('admin/articles') && params[:action] == 'show'
      'Просмотр статьи'
    else
      obj     = @article || @work
      return obj.get_content(current_lang).title if obj.present?
      
      case params[:controller]
      when 'works'
        I18n.t("views.header.titles.works")
      when 'pages'
        I18n.t("views.header.titles.about_me")
      else
        I18n.t("views.header.titles.articles")
      end
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def current_controller?(controller_names)
    controller_names = [controller_names] unless controller_names.instance_of?(Array)
    controller_names.any? {|controller_name| controller_name.to_s == params[:controller].to_s }
  end

  def get_page_logo
    content_tag :h2, class: 'page-logo' do
      I18n.t("views.header.I")
    end
  end

  def current_lang_flag
    get_flag_for_lang(current_lang.to_sym)
  end

  def display_actions_for(object, namespace='')
    resource_name = object.class.to_s.underscore
    content_tag :div, class: 'btn-group btn-group-xs pull-right' do
      content = content_tag :button, class: 'btn btn-default dropdown-toggle', 'data-toggle' => 'dropdown', 'aria-expanded' => false do
        button = 'Действия '.html_safe
        button += "<span class='caret'> </span>".html_safe 
      end
      content += content_tag :ul, class: 'dropdown-menu', role: 'menu' do
        ul  = content_tag :li do
              link_to 'Просмотр', [namespace, object]
            end
        ul += content_tag :li do
              method =  if namespace.present?
                          "edit_#{namespace}_#{resource_name}_path"
                        else
                          "edit_#{resource_name}_path"
                        end
              
              link_to 'Изменить', send(method, object)
            end
        
        ul +=  content_tag(:li) { yield(object) } if block_given? #для дополнительных кнопок
        
        ul += content_tag :li do
              link_to 'Удалить', [namespace, object], method: :delete, data: { confirm: 'Вы уверены что хотите удалить?' }
            end
        ul
      end
    end
  end

  def current_path_to_anothre_lang
    get_path_to_controller_and_action(params[:controller], params[:action])
  end

  def current_lang_russian?
    current_lang.eql?(:ru)
  end

  def current_lang_english?
    current_lang.eql?(:en)
  end

  def get_available_languages_for_page(object)
    content_tag :div, class: 'pull-right btn-group available-languages' do
      [:en, :ru].inject(''.html_safe) do |res, lang|
        content = object.get_content(lang)
        if content.published?
          class_list = 'btn btn-default'
          class_list += ' active' if current_lang.eql?(lang)
          res += link_to({lang: lang}, {class: class_list}) do
            content_tag :i, '', class: "famfamfam-flag-#{get_flag_for_lang(lang)}"
          end
        end
        res
      end
    end
  end

  private
    def get_flag_for_lang(lang)
      return :gb if lang.eql?(:en)
      lang
    end

    def another_lang
      @another_lang ||= current_lang_english? ? :ru  : :en
      @another_lang
    end

    def get_path_to_controller_and_action(controller, action)
      case action
      when 'index'
        send("#{controller}_path", lang: another_lang)
      when 'show'
        object   = @article
        object ||= @work
        return send("#{controller}_path", lang: another_lang) unless object.get_content(another_lang).published?
        send("#{controller.singularize}_path", lang: another_lang)
      when 'about_me'
        about_me_path(lang: another_lang)
      when 'new'
        new_user_session_path(lang: another_lang)  
      else
        root_url(lang: another_lang)
      end
    end
      

end
