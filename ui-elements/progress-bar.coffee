Yuri.widget["progress-bar"] = ->
  template: """<div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"><span class="sr-only"></span></div>"""
  options:
    animate: true
    animationDuration: 200
    # Number (ie: 50) or Array of Objects (ie: {value: 50, type: success, striped: true, ...})
    value: 0
    # types: [success, info, warning, danger]
    type: null
    active: false
    striped: false
    withLabel: false
    label: (value) ->
      return value + "%"

  initialize: (options) ->
    @$el = $(options.el)

    $.extend @options, options

    @render()

  # setter/getter if value == null, then it acts as getter
  value: (value)->
    if value
      @options.value = value
      if typeof value == "number"
        @$el.find(".progress-bar")
          .css "width", @options.value + "%"
          .attr "aria-valuenow", @options.value

        if @options.withLabel
          @$el.find(".progress-bar").text @options.label(@options.value)
        else
          @$el.find(".sr-only").text @options.label(@options.value)
      else # value is an array
        $(@options.value).each (idx, val) =>


    $("body").trigger "Yuri:ProgressBar:Value:Changed", [{widget: @, value: value}]
    return @options.value

  configureBar: ($progressBar, options) ->
    if options.animate
      $progressBar.css "transition", "width " + options.animationDuration + " ease-in-out"
    else
      $progressBar.css "transition", "initial"
      @options.animationDuration = 0

    if options.type
      $progressBar.addClass "progress-bar-" + options.type

    if options.active
      $progressBar.addClass "active"

    if options.striped
      $progressBar.addClass "progress-bar-striped"

    if options.withLabel
      $progressBar.find(".sr-only").remove()
      $progressBar.text @options.label(options.value)
    else
      $progressBar.find(".sr-only").text @options.label(options.value)

    # Fast-fix: If we don't do this, the CSS transition to animate the bar doesn't work.
    setTimeout =>
      $progressBar
        .css "width", options.value + "%"
        .attr "aria-valuenow", options.value
    , 0

  render: ()->
    @$el.addClass "progress"

    if typeof @options.value == "number"
      @$el.append @template
      @configureBar @$el.find(".progress-bar"), @options
    else # array
      $(@options.value).each (idx, val) =>
        @$el.append @template
        @configureBar @$el.find(".progress-bar").last(), val


    return @





