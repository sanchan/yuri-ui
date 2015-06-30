Yuri.widget["input-group"] = ->
  templateAddon: """<span class="input-group-addon"></span>"""
  templateInput: """<input type="text" class="form-control">"""
  templateButton: """<span class="input-group-btn"></span>"""

  options:
    id: null # MANDATORY
    # sizes: [lg, default, sm, xs]
    size: "default"
    items: []

  initialize: (options) ->
    @$el = $(options.el)

    $.extend @options, options

    @render()

  render: ()->
    @$el.addClass("input-group")
    @$el.addClass "input-group-" + @options.size if @options.size != "default"


    $(@options.items).each (idx, item) =>
      console.error "ERROR: 'id' option missing for 'input-group' item" if item.type == "input" and not item.id

      itemOptions =
        type: "text"
        text: ""
        placeholder: null

      $.extend itemOptions, item

      if itemOptions.view == "addon"
        @$el.append @templateAddon
        # if there isn't any item type, then it's a string addon
        @$el.find(".input-group-addon").last().text itemOptions.text if itemOptions.type == "text"
      else if itemOptions.view == "input"
        @$el.append @templateInput
        $input = @$el.find(".form-control").last()

        if itemOptions.type == "checkbox" or itemOptions.type == "radio"
          @$el.append @templateAddon
          $input.appendTo @$el.find(".input-group-addon").last()
          $input.attr "type", itemOptions.type
          $input.removeClass "form-control"

        $input.attr "id", itemOptions.id
        $input.attr "placeholder", itemOptions.placeholder if itemOptions.placeholder
      else if itemOptions.view == "button"
        $buttonGroup = $(@templateButton)
        @$el.append $buttonGroup
        $button = $("<button></button>")
        $buttonGroup.append $button
        $button.attr "id", itemOptions.id

        button = Yuri.ui
          view: "button"
          text: itemOptions.text
          el: "#" + itemOptions.id
      else if itemOptions.view == "dropdown"
        $buttonGroup = $("<div class='input-group-btn'></div>")
        @$el.append $buttonGroup

        itemOptions.view = "dropdown"
        itemOptions.el = $buttonGroup
        button = Yuri.ui
          view: "dropdown"
          text: itemOptions.text
          el: $buttonGroup
          id: itemOptions.id
          menu: itemOptions.menu
          split: itemOptions.split
          menuAlign: itemOptions.menuAlign

        $buttonGroup.removeClass "btn-group"

    return @