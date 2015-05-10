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
                              addNewEntity(lang, search_query)

  addNewEntity: (select, search_query) ->
    value: search_query, text: search_query

  submitForm: (e) ->
    



window.ArticleForm = ArticleForm