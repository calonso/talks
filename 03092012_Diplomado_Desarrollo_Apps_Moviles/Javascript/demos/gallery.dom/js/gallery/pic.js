(function() {
    GALLERY.Pic = function(source) {
        this.el = document.createElement('img');
        this.el.src = source;
    };
    
    GALLERY.Pic.prototype = {
        el: null   /** The HTML Element */
    };
})();