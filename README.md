# yuri-ui
A Javascript library to create Bootstrap components without HTML.

# Why?
Because in some moment I found interesting to create a tool for fast prototyping. I love Bootstrap and I though it could be a good idea just to create Bootstrap's components just with a single line on the DOM and configuring with JSON data from the Javascript file.

# Components

## Buttons
<p>For buttons you can define the contextual type setting the <code>type</code> option. The valid <code>type</code> values are <code>"default", "primary", "success", "info", "warning", "danger"</code>.</p>
<p>Also you can set an icon setting the <code>icon</code> option. You can use any prefix used by <code>Glyphicon</code> icons set. For example, if you want to use the <code>glyphicon-star</code> icon, the you just need to set <code>icon: "star"</code>:</p>

### HTML
```html
<button id="button-primary"></button>
```

### Javascript
```javascript
Yuri.ui({
  view: "button",
  el: "#button-primary",
  type: "primary",
  text: "Primary",
  icon: "star"
});
```

### Result
```html
<button id="button-primary" class="btn btn-primary">
    <span class="text">Primary  </span>
    <span class="glyphicon glyphicon-star"></span>
</button>
```
