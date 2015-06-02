class App.Admin.WorkForm extends Spine.Controller
  constructor: ->
    super
    new App.Admin.FileUploader el: @el

