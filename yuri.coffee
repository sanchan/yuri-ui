window.Yuri = {
  widget: {}
} if not window.Yuri

Yuri.ui = (options) ->
  switch options.view
    when "dropdown" then (new Yuri.widget["dropdown"]).initialize(options)
    when "progress-bar" then (new Yuri.widget["progress-bar"]).initialize(options)
    when "button" then (new Yuri.widget["button"]).initialize(options)
    when "button-group" then (new Yuri.widget["button-group"]).initialize(options)
    when "button-toolbar" then (new Yuri.widget["button-toolbar"]).initialize(options)
    when "nav" then (new Yuri.widget["nav"]).initialize(options)
    when "input-group" then (new Yuri.widget["input-group"]).initialize(options)