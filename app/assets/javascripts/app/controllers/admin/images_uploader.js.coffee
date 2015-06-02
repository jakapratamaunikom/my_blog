class ImageItem extends Spine.Controller
  className: 'col-xs-3 image-container'
  events:
    'click .remove':  'markAsRemoveImg'
    'click .restore': 'restoreImg'

  constructor: ->
    super
    @initAndDisplayImage()

  initAndDisplayImage: ->
    if @image.isUploaded()
      @html @view("admin/image_uploader/image")(file: @image.url)
    else
      reader = new FileReader()
      reader.onload = (e) =>
        image_base64 = e.target.result
        @html @view("admin/image_uploader/image")(file: image_base64)

      reader.readAsDataURL(@image.data.files[0])

  markAsRemoveImg: (e) ->
    e.preventDefault()
    @el.find(".thumbnail").addClass('was-deleted')
    @image._destroy = true
    @image.save()

  restoreImg: (e) ->
    e.preventDefault()
    @el.find(".thumbnail").removeClass('was-deleted')
    @image._destroy = false
    @image.save()

###########################
###########################

class App.Admin.ImageUploadForm extends Spine.Controller
  @extend Spine.Events

  elements:
    '#preview': 'preview'
    '#progress_bar .progress-bar': 'progress_bar'

  constructor: ->
    super
    @whiteList = /(\.|\/)(gif|jpe?g|JPE?G|png)$/
    @setupFileUploader()
    @amount_of_uploaded_files  = 0
    @renderExistingImages()

  renderExistingImages: ->
    for container in @el.find("[data-type=image]")
      do (container) =>
        image = App.Image.create id: $(container).data('id'), kind: 'uploaded', url: $(container).data('url'), _destroy: false
    
        thumb = new ImageItem image: image
        @preview.append thumb.el


  setupFileUploader: ->
    @el.fileupload
                  dataType: 'json',
                  done: @done
                  add:  @add

  done: (e, data) =>
    App.Image.create id: data.result.id, kind: 'uploaded', '_destroy': false
    @amount_of_uploaded_files += 1
    @trigger 'allFilesUploads' if @percent() == 100
    percent = "#{@percent()}%"
    @progress_bar.width percent
    @progress_bar.html  percent
  
  percent: ->
    amount_of_files_to_upload = App.Image.getImagesForUploading().length
    parseInt(@amount_of_uploaded_files/amount_of_files_to_upload * 100)

  add: (e, data) =>
    unless @whiteList.exec(data.files[0].name)
      window.displayNotices('Неверный формат файлов. Для загрузки доступны gif, jpeg, png') 
      return 

    image = new App.Image data: data, kind: 'for_uploading', '_destroy': false
    image.save()

    thumb = new ImageItem image: image
    @preview.append thumb.el

  submit: (image_ids) ->
    if App.Image.getImagesForUploading().length == 0
      @trigger 'allFilesUploads' 
    else
      @el.find("#progress_bar").removeClass('hide')

      for image in App.Image.getImagesForUploading()
        image.data.submit()

##############################
##############################
