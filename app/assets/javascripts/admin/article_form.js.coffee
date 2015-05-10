class ArticleForm
  constructor: (el) ->
    @el = el
    @setupPreview()
    @setupSelectize()

  setupSelectize: ->
    for select in @el.find("select[data-type=tags]")
      do (select) ->
        $(select).selectize()

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



window.ArticleForm = ArticleForm