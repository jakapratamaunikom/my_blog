module ArticlesHelper
  def options_for_article_tags(article_form, language)
    result = ''.html_safe
    Tag.all.each do |tag|
      attributes = { value: tag.id }
      attributes.merge!({selected: 'selected'}) if article_form.is_tag_selected?(tag, language)
      result += content_tag :option, tag.to_s, attributes
    end
    # options = options_from_collection_for_select(Tag.send(language), 'id', 'to_s')
    # article_form.send("#{language}_articles_new")
    result
  end

  def display_article_content_tags(article_content)
    article_content.tags.inject("".html_safe) do |res, tag|
      res += content_tag :label, tag.to_s, class: "label label-default"
      res += ' '
    end
  end

  def display_tags_cloud_for(lang)

    content_tag :ul, class: 'tags' do
      Tag.send(lang).inject("".html_safe) do |cloud, tag|
        cloud += content_tag :li do
          class_list = ''
          class_list += 'active ' if session[:tag_ids].include?(tag.id) 
          link_to tag.to_s, mark_tag_path(tag), method: :put, class: class_list
        end
      end
    end
  end


end
