(($, window) ->
  
  #------------------------------------------------------------
  # SubSub - Create toggleable sub-pages. Infinitely.
  #------------------------------------------------------------
  # 
  # I needed an easy way to toggle between different screens
  # on CodePen to show off different UI states, so using
  # CSS' :checked functionality, this plugin creates
  # a hierarchy of screens that all can toggled
  # between. Sort of like a single-page app.
  #
  # = Example ==================================================
  # 
  # First, write some HTML:
  #
  # <div class="first-layer" data-subsub="screen">
  #  <div class="screen" data-name="First Page">
  #    <h1>Hello from the first page</h1>
  #  </div>
  #  <div class="screen" data-name="Second Page">
  #    <h1>Hello from the second page</h1>
  #  </div>  
  # </div>
  #
  # Second, call SubSub in your scripts:
  #
  # $('[rel="data-subsub"]').subSub();
  #
  # or 
  #
  # $('.first-layer, .second-layer').subSub();
  # 
  # For more, see: http://codepen.io/andersschmidt/pen/EaoPwM/
  #
  # Support: I can't give any, sorry. Don't have the time.
  #
  # ============================================================
  
  class SubSub
 
    defaults: {}
 
    constructor: (el, options) ->
      @options = $.extend({}, @defaults, options)
      @$el = $(el)
      @generatePages()
      
    slugify: (str) ->
      str = str.replace(/^\s+|\s+$/g, "").toLowerCase()
      str = str.replace(/[^a-z0-9 -]/g, "").replace(/\s+/g, "-").replace(/-+/g, "-")
    
    styleTagAdded = false
    
    generatePages: () ->
      screens = @$el.attr 'data-subsub'
      label_class = @$el.attr 'data-label-class'
      
      if styleTagAdded is false
        styleTagAdded = true
        $('head').append """<style id="subsub_styles"></style>"""
        
      
      $('head style#subsub_styles').append """
        .subsub-screen-selector:checked+.#{screens}{display:block !important;}
      """
      
      @$el.prepend """<nav class="  subsub #{screens}-navigator"></nav>"""
      
      for screen in $(".#{screens}")
        screen_id         = @slugify( $(screen).attr 'data-name' )
        screen_visible = $(screen).attr 'checked'
        screen_name = $(screen).attr 'data-name'
        
        $(screen)
        .addClass 'subsub-screen'
        .css 'display', 'none'
        
        $(".#{screens}-navigator").append """ <label for="change-to-#{screen_id}" class="#{label_class}">#{screen_name}</label>"""
        
        $("""<input type="radio" class="subsub-screen-selector" id="change-to-#{screen_id}" name="#{screens}" #{screen_visible} style="display:none;">""").insertBefore screen      
      
  $.fn.extend subSub: (option, args...) ->
    @each ->
      $this = $(this)
      data = $this.data('subSub')
 
      if !data
        $this.data 'subSub', (data = new SubSub(this, option))
      if typeof option == 'string'
        data[option].apply(data, args)
 
) window.jQuery, window