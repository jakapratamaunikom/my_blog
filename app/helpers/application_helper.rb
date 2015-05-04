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
      'Блог Алексея В.'
    end
  end

  def current_controller?(controller_names)
    controller_names = [controller_names] unless controller_names.instance_of?(Array)
    controller_names.any? {|controller_name| controller_name.to_s == params[:controller].to_s }
  end

  def get_page_logo
    content_tag :h2, class: 'page-logo' do
      'Алексей В.'
    end
  end


   def display_actions_for(object)
    resource_name = object.class.to_s.underscore
    content_tag :div, class: 'btn-group btn-group-xs pull-right' do
      content = content_tag :button, class: 'btn btn-default dropdown-toggle', 'data-toggle' => 'dropdown', 'aria-expanded' => false do
        button = 'Действия '.html_safe
        button += "<span class='caret'> </span>".html_safe 
      end
      content += content_tag :ul, class: 'dropdown-menu', role: 'menu' do
        ul  = content_tag :li do
              link_to 'Просмотр', object
            end
        ul += content_tag :li do
              link_to 'Изменить', send("edit_#{resource_name}_path", object)
            end
        
        ul +=  content_tag(:li) { yield(object) } if block_given? #для дополнительных кнопок
        
        ul += content_tag :li do
              link_to 'Удалить', object, method: :delete, data: { confirm: 'Вы уверены что хотите удалить?' }
            end
        ul
      end

    end
  end
end
