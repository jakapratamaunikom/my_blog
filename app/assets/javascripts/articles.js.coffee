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
    @el.on "click", "a[data-type=reply_comment]", @replyComment
  
  replyComment: (e) =>
    e.preventDefault()
    comment_id = $(e.currentTarget).data('id')
    form = @el.find("#create-comment form")
    form.find("#comment_parent_id").val comment_id

    @setCursorToTarget form

  setCursorToTarget: (form) =>
    return if form.length == 0
    setTimeout (=> # с задержкой в 0,5 секунд на прорисовку элементов
      body_offset   = $('body').offset().top
      navbar_height = $(".navbar.navbar-inverse.navbar-fixed-top").height()
      accordion_title_height = @el.find("a[data-type=title][href=#question_#{@edited_question}]").closest(".panel-heading").outerHeight()
      $('body').animate({scrollTop: form.offset().top - body_offset - navbar_height - accordion_title_height }, 300) # 50 - высота фиксированной верхней панели
    )
    form.find("#comment_name").focus()



window.ShowArticle = ShowArticle
