Yuri.widget["nav"] = ->

  options:
    # types: [tabs, pills]
    type: "tabs"
    entries: []

  initialize: (options) ->
    @$el = $(options.el)

    $.extend @options, options

    @render()

  render: ()->
    @$el.addClass("nav").addClass "nav-" + @options.type
    $(@options.entries).each (idx, val) =>
      self = this
      $itemLink = $("<a>")
      $itemLink.text(val.text)
      $item = $("<li>")
          .attr("data-index", idx)
          .append $itemLink
          .click ->
            $("body").trigger "Yuri:Nav:Selected", [{widget: @, index: idx}]
            self.$el.find(".active").removeClass("active")
            $(this).addClass("active")

      $itemLink.attr "href", val.url if val.url

      @$el.append $item
      if val.active
        @$el.find(".active").removeClass("active")
        @$el.find("li").last().addClass("active")