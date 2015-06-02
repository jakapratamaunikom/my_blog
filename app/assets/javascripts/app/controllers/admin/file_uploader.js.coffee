class App.Admin.FileUploader extends Spine.Controller
  constructor: (el) ->
    super
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

