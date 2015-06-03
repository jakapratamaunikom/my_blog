class WorkFieldsForm extends Spine.Controller
  constructor: ->
    super
    new App.Admin.AvatarUploader el: @el
    new App.FormValidator el: @el

  valid: ->
    @el.valid()

  submit: =>
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
      @beginUploadsPicturesAndThenSaveSupplyDocument()

  beginUploadsPicturesAndThenSaveSupplyDocument: ->
    @images_form.submit()


