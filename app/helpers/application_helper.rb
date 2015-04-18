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
end
