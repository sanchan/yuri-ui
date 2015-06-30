Yuri.widget["button-toolbar"] = ->
  options:
    id: null # MANDATORY
    button: []
    # sizes: [lg, default, sm, xs]
    size: "default"

  initialize: (options) ->
    @$el = $(options.el)

    $.extend @options, options

    @render()

  render: ()->

    @$el.addClass("btn-toolbar").attr("role", "toolbar")

    $(@options.groups).each (idx, group)=>
      console.error "ERROR: 'id' option missing for each 'button-toolbar' entry " if not group.id
      @$el.append("<div></div>")
      @$el.find("div").last().attr "id", group.id
      group.view = "button-group"
      group.el = "#" + group.id
      group.size = @options.size if @options.size != "default"
      Yuri.ui group


    return @
