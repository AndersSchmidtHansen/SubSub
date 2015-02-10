(function() {
  var __slice = [].slice;

  (function($, window) {
    var SubSub;
    SubSub = (function() {
      var styleTagAdded;

      SubSub.prototype.defaults = {};

      function SubSub(el, options) {
        this.options = $.extend({}, this.defaults, options);
        this.$el = $(el);
        this.generatePages();
      }

      SubSub.prototype.slugify = function(str) {
        str = str.replace(/^\s+|\s+$/g, "").toLowerCase();
        return str = str.replace(/[^a-z0-9 -]/g, "").replace(/\s+/g, "-").replace(/-+/g, "-");
      };

      styleTagAdded = false;

      SubSub.prototype.generatePages = function() {
        var label_class, screen, screen_id, screen_name, screen_visible, screens, _i, _len, _ref, _results;
        screens = this.$el.attr('data-subsub');
        label_class = this.$el.attr('data-label-class');
        if (styleTagAdded === false) {
          styleTagAdded = true;
          $('head').append("<style id=\"subsub_styles\"></style>");
        }
        $('head style#subsub_styles').append(".subsub-screen-selector:checked+." + screens + "{display:block !important;}");
        this.$el.prepend("<nav class=\" subsub " + screens + "-navigator\"></nav>");
        _ref = $("." + screens);
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          screen = _ref[_i];
          screen_id = this.slugify($(screen).attr('data-name'));
          screen_visible = $(screen).attr('checked');
          screen_name = $(screen).attr('data-name');
          $(screen).addClass('subsub-screen').css('display', 'none');
          $("." + screens + "-navigator").append(" <label for=\"change-to-" + screen_id + "\" class=\"" + label_class + "\">" + screen_name + "</label>");
          _results.push($("<input type=\"radio\" class=\"subsub-screen-selector\" id=\"change-to-" + screen_id + "\" name=\"" + screens + "\" " + screen_visible + " style=\"display:none;\">").insertBefore(screen));
        }
        return _results;
      };

      return SubSub;

    })();
    return $.fn.extend({
      subSub: function() {
        var args, option;
        option = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        return this.each(function() {
          var $this, data;
          $this = $(this);
          data = $this.data('subSub');
          if (!data) {
            $this.data('subSub', (data = new SubSub(this, option)));
          }
          if (typeof option === 'string') {
            return data[option].apply(data, args);
          }
        });
      }
    });
  })(window.jQuery, window);

  $(function() {
    return $('[data-subsub]').subSub();
  });

}).call(this);
