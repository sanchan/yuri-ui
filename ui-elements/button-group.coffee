Yuri.widget["button-group"] = ->
  options:
    button: []
    # sizes: [lg, default, sm, xs]
    size: "default"
    vertical: false
    justified: false

  initialize: (options) ->
    @$el = $(options.el)

    $.extend @options, options

    @render()

  render: ()->
    if @options.vertical
      @$el.addClass "btn-group-vertical"
    else
      @$el.addClass "btn-group"
      @$el.addClass "btn-group-justified" if @options.justified

    @$el.addClass "btn-group-" + @options.size if @options.size != "default"

    $(@options.buttons).each (idx, button)=>

      if button.view == "dropdown"
        @$el.append "<div class='btn-group'></button>"
        @$el.find(".btn-group").last().attr "id", button.id + "-" + idx
        @$el.find(".btn-group").last().addClass "btn-group-" + @options.size if @options.size != "default"

        button.el = "#" + button.id + "-" + idx
        button.buttonTag = "anchor" if @options.justified
        buttonUI = Yuri.ui button
      else # button
        if @options.justified
          @$el.append "<a></a>"
          @$el.find("a").last().attr "id", button.id
        else
          @$el.append "<button></button>"
          @$el.find("button").last().attr "id", button.id


        button.view = "button"
        button.el = "#" + button.id
        buttonUI = Yuri.ui button


    return @
