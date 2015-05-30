class WorkForm
  constructor: (el) ->
    @el = el
    new App.FileUploader @el

App.WorkForm = WorkForm