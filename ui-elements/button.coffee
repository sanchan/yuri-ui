Yuri.widget["button"] = ->
  template: """<span class="text"></span>"""
  templateIcon: """<span class="glyphicon"></span>"""
  templateCaret: """<span class="caret"></span>"""

  options:
    id: null
    text: ""
    # types: [default, primary, success, info, warning, danger]
    type: "default"
    icon: null
    iconPosition: "right"
    caret: false

  initialize: (options) ->
    if typeof options.el == "string"
      @$el = $(options.el)
    else # jQuery Object
      @$el = options.el

    $.extend @options, options

    @render()

  render: ()->
    @$el.append @template

    @$el.attr "id", @options.id if @options.id # TODO Remove the 'if' because the 'id' MUST be mandatory. Removing the 'if' should break almost everything right now, because almost nobody is setting an id to a button widget :)

    @$el.addClass("btn").addClass "btn-" + @options.type
    if @options.text
      @$el.find(".text").text @options.text + " "
    else
      @$el.find(".text").remove()

    @$el.append @templateCaret if @options.caret
    @$el.append $("<span class='sr-only'>Dropdown</span>") if @options.text == ""

    if @options.icon
      if @options.iconPosition == "right"
        @$el.append @templateIcon
        @$el.find(".text").append " "
      else # @options.iconPosition == "left"
        @$el.prepend @templateIcon
        @$el.find(".text").prepend " "

      @$el.find(".glyphicon").addClass "glyphicon-" + @options.icon if @options.icon

    @$el.click =>
      $("body").trigger "Yuri:Button:Click", [{widget: @}]

    return @
