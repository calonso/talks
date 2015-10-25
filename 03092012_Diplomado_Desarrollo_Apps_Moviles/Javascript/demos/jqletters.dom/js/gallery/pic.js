(function() {
    GALLERY.Pic = function(source) {
        this.$el = $('<img>', {src: source});
    };
    
    GALLERY.Pic.prototype = {
        $el: null   /** The HTML Element */
    };
})();