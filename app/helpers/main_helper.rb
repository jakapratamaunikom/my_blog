module MainHelper
  def display_tags_cloud_for(lang)
    content_tag :ul, class: 'tags' do
      Tag.send(lang).inject("".html_safe) do |cloud, tag|
        cloud += content_tag :li do
                    content_tag :a, href: '#' do
                      tag.to_s
                    end
                  end
      end
    end
  end
end
