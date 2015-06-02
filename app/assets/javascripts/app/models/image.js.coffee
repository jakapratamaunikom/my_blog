class App.Image extends Spine.Model
  #TODO должен быть без ajax
  #используется для сохранение коллекции картинок в работе
  @configure 'Image', 'id', 'kind', 'url', 'data', '_destroy'

  @getImagesForDestroy: ->
    @select (image) ->
      image._destroy == true and image.kind == 'uploaded'
    
  @getImagesForAdding: ->
    @select (image) ->
      image._destroy == false and image.kind == 'uploaded'

  @getImagesForUploading: ->
    @select (image) ->
      image._destroy == false and image.kind == 'for_uploading'

  isUploaded: ->
    @kind == 'uploaded'