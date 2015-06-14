class App.Admin.PrideForm extends Spine.Controller
  constructor: ->
    super
    @setupSelectize()

  setupSelectize: ->
    createTag = @createTag
    for select in @el.find("select")
      do (select) =>
        $(select).selectize(maxItems: 5)
