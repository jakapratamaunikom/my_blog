class FileUploaser 
  constructor: (el) ->
    @el = el
    @setupPreview()

  setupPreview: ->
    for input in @el.find("[rel=avatar]")
      do (input) =>
        preview = @el.find("[data-source=#{$(input).data('type')}]")
        $(input).change (event) -> 
          file = input.files[0]
          reader = new FileReader()
          
          reader.onload = (e) ->
            image_base64 = e.target.result
            preview.attr("src", image_base64)
            preview.removeClass('hide')
          reader.readAsDataURL(file)

##########################
##########################
    
class ArticleForm
  constructor: (el) ->
    @el = el
    new FileUploaser @el
    @setupSelectize()
    @el.bind 'submit', @submitForm

  setupSelectize: ->
    addNewEntity = @addNewEntity
    for select in @el.find("select[data-type=tags]")
      do (select) ->
        $(select).selectize
                            render: 
                              option_create: (data, escape) ->
                                return '<div class="create">Добавить <strong>' + escape(data.input) + '</strong>&hellip;</div>'
                            create: (search_query) ->
                              lang = @.$input.data('lang')
                              $.ajax
                                type: 'post'
                                url:  '/admin/tags'
                                data: tag: {lang: lang, title: search_query}
                                dataType: 'json'
                                success: addNewEntity
                              {value: '', text: ''}


  addNewEntity: (data, status, request) =>
    console.log data
    select = @el.find("select[data-lang=#{data.lang}]")[0]
    select.selectize.addOption value: data.id, text: data.title
    values = select.selectize.getValue()
    values.push(data.id)
    select.selectize.setValue(values)

  submitForm: (e) ->




window.ArticleForm = ArticleForm