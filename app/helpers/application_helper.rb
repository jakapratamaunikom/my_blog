module ApplicationHelper
  def get_page_title
    'Блог Алексея В.'
  end

  def current_controller?(controller_names)
    controller_names = [controller_names] unless controller_names.instance_of?(Array)
    controller_names.any? {|controller_name| controller_name.to_s == params[:controller].to_s }
  end
end
