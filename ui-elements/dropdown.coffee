# TODO Remove options.grouped. We have to create the context on the parent. This widget MUSTN'T create ANYTHING else that it's content.
Yuri.widget["dropdown"] = ->
  templateButton: """
    <button class="btn dropdown-toggle" type="button" data-toggle="dropdown"></button>
    <ul class="dropdown-menu" role="menu" aria-labelledby=""></ul>
  """

  templateAnchor: """
    <a class="btn dropdown-toggle" type="button" data-toggle="dropdown"></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby=""></ul>
  """

  templateButtonSplit: """
    <button class="btn" type="button"></button>
    <button class="btn dropdown-toggle" type="button" data-toggle="dropdown"></button>
    <ul class="dropdown-menu" role="menu" aria-labelledby=""></ul>
  """

  templateAnchorSplit: """
    <a class="btn" type="button"></a>
    <a class="btn dropdown-toggle" type="button" data-toggle="dropdown"></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby=""></ul>
  """

  templateMenuItem: """<li role="presentation"><a role="menuitem" tabindex="-1" href="#"></a></li>"""
  templateDivider: """<li role="presentation" class="divider"></li>"""
  templateMenuHeader: """<li role="presentation" class="dropdown-header"></li>"""


  options:
    text: ""
    id: null
    # types: [default, primary, success, info, warning, danger]
    type: "default"
    menuAlign: "left"
    menu: []
    buttonTag: "button"
    split: false
    grouped: false
    # sizes: [lg, sm, xs]
    size: null
    dropup: false

  initialize: (options) ->
    @$el = $(options.el)

    $.extend @options, options

    @render()

  render: ()->
    if @options.buttonTag == "button"
      if @options.split
        @$el.append @templateButtonSplit
      else
        @$el.append @templateButton
    else # anchor
      if @options.split
        @$el.append @templateAnchorSplit
      else
        @$el.append @templateAnchor

    # if @options.grouped then it's a grouped dropdown, else it's a common dropdown
    if @options.grouped || @options.split
      @$el.addClass "btn-group"
    else
      @$el.addClass "dropdown"


    @$el.find(".btn").addClass "btn-" + @options.size if @options.size

    @$el.addClass "dropup" if @options.dropup

    console.error "ERROR: 'id' option missing for 'dropdown' widget " if not @options.id

    @$el.find(".btn").first().addClass("btn-" + @options.type).attr "id", @options.id
    @$el.find(".dropdown-menu").attr "aria-labelledby", @options.id

    if @options.split
      @button = Yuri.ui
        view: "button"
        el: "#" + @options.id
        type: @options.type
        text: @options.text
        caret: false

      @$el.find(".btn").last().addClass("btn-" + @options.type).attr "id", @options.id + "-caret"
      @button = Yuri.ui
        view: "button"
        el: "#" + @options.id + "-caret"
        type: @options.type
        text: ""
        caret: true

      # NOTE This is a FIX, without this, the size of the caret doesn't match with the height of the button on the left
      # We are setting the same height of the left button to the caret button
      $("#" + @options.id + "-caret").height $("#" + @options.id).height()
    else
      @button = Yuri.ui
        view: "button"
        el: "#" + @options.id
        type: @options.type
        text: @options.text
        caret: true

    @$el.find(".dropdown-menu").addClass "dropdown-menu-right" if @options.menuAlign == "right"

    $(@options.menu).each (idx, val)=>
      if val.type == "divider"
        @$el.find(".dropdown-menu").append @templateDivider
      else if val.type == "header"
        @$el.find(".dropdown-menu").append @templateMenuHeader
        $menuItem = @$el.find(".dropdown-menu > li").last()
        $menuItem.text val.text
      else # Item
        @$el.find(".dropdown-menu").append @templateMenuItem
        $menuItem = @$el.find(".dropdown-menu > li").last()
        $menuItem.addClass "disabled" if val.disabled
        $menuItem.find("a").text val.text
        $menuItem.click =>
          $("body").trigger "Yuri:Dropdown:MenuItem:Click", [{widget: $menuItem, index: idx, itemOptions: val}]

    $("body").on "click", =>
      @$el.removeClass "open"

    @$el.find(".btn").click (ev)=>
      # This 'if' is because if we are using a split button, the 'open' class must be added just if the clicked element is the caret button.
      @$el.toggleClass "open" if $(ev.target).closest(".btn").hasClass "dropdown-toggle"
      ev.stopPropagation()
      $("body").trigger "Yuri:Dropdown:Click", [{widget: @}]

