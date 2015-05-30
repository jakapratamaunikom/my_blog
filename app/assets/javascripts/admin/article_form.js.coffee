class ArticleForm
  constructor: (el) ->
    @el = el
    new App.FileUploader @el
    @setupSelectize()

  setupSelectize: ->
    createTag = @createTag
    for select in @el.find("select[data-type=tags]")
      do (select) =>
        $(select).selectize
                            render: 
                              option_create: (data, escape) ->
                                return '<div class="create">Добавить <strong>' + escape(data.input) + '</strong>&hellip;</div>'
                            create: (search_query) ->
                              lang = @.$input.data('lang')
                              createTag(lang, search_query)
                              {value: '', text: ''}

  createTag: (lang, title) =>
    $.ajax
      type: 'post'
      url:  '/admin/tags'
      data: tag: {title: title}
      dataType: 'json'
      success: (data) =>
        for select in @el.find("select[data-type=tags]")
          do (select) ->
            select.selectize.addOption value: data.id, text: data.title
        select = @el.find("select[data-lang=#{lang}]")[0]
        values = select.selectize.getValue()
        values.push(data.id)
        select.selectize.setValue(values)



App.ArticleForm = ArticleForm