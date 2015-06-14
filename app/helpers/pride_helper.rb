module PrideHelper
  def options_for_pride_items(pride_form, language)
    result    = ''.html_safe
    all_items = []
    
    result += content_tag :optgroup, label: 'Статьи' do
      Article.published(language).inject(''.html_safe) do |select_group, article|
        attributes = {value: ['Article', article.id]}
        attributes.merge!({selected: 'selected'}) if pride_form.is_article_select?(article)
        select_group += content_tag :option, article.get_content(language).title, attributes
      end
    end
    
    result += content_tag :optgroup, label: 'Мои работы' do
      Work.published(language).inject(''.html_safe) do |select_group, work|
        attributes = {value: ['Work', work.id]}
        attributes.merge!({selected: 'selected'}) if pride_form.is_work_select?(work)
        select_group += content_tag :option, work.get_content(language).title, attributes
      end
    end

    result
  end

end
