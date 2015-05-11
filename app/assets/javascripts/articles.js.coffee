class FormValidator 
  constructor: (el) ->
    @el = el
    @initFormValidator()

  initFormValidator: ->
    @el.validate
      ignore: ""
      
      highlight: (element) ->
        $(element).closest(".js-field-container").addClass "has-error"
        return

      unhighlight: (element) ->
        $(element).closest(".js-field-container").removeClass "has-error"
        return

      errorElement: "span"
      errorClass: "text-danger"
  
class ShowArticle
  constructor: (el) ->
    @el = el
    new FormValidator $(form) for form in @el.find("form")



window.ShowArticle = ShowArticle
