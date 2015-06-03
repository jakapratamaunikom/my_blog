class WorkFieldsForm extends Spine.Controller
  constructor: ->
    super
    new App.Admin.AvatarUploader el: @el
    new App.FormValidator el: @el

  valid: ->
    @el.valid()

  submit: =>
    image_ids = _.map(App.Image.getImagesForAdding(), 'id')
    for image_id in image_ids
      do (image_id) =>
        input = $("<input type='hidden' value=#{image_id} name='work[image_ids][]'>")
        @el.find("[data-type=set_image_ids]").append input
    @el.submit()


###################
###################
###################

class App.Admin.WorkForm extends Spine.Controller
  events:
    'click [data-type=submit]': 'submitForms'

  constructor: ->
    super
    @work_form   = new WorkFieldsForm el: @el.find("[data-type='work']")
    @images_form = new App.Admin.ImageUploadForm el: @el.find("[data-type=images]")

    @images_form.bind 'allFilesUploads', @work_form.submit

  submitForms: (e) ->
    e.preventDefault()
    if @work_form.valid()
      $(e.currentTarget).addClass('disabled')
      $(e.currentTarget).next().addClass("disabled")
      @beginUploadsImagesAndThenSaveSupplyDocument()

  beginUploadsImagesAndThenSaveSupplyDocument: ->
    @images_form.submit()


