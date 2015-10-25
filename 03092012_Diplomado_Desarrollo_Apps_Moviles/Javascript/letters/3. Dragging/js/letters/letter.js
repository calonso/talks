(function() {
    LETTERS.Letter = function(source, index) {
        this.el = document.createElement('img');
        this.el.src = source;
        
        this.el.classList.add('letter');
        var css =  window.getComputedStyle(this.el, null);
        this.el.style.left = parseInt(css.width) * index + "px";
        
        this.el.addEventListener('mousedown', clickClosure, false);
        
        var self = this;
        function clickClosure(evt) {
            self.clicked(evt);
        }
    };
    
    LETTERS.Letter.prototype = {
        el: null,   /** The HTML Element */
        
        clicked: function(evt) {
            this.el.classList.add('dragging');
            var self = this;
            drag(this.el, evt, function() {
                self.released(evt);
                });
        },
        
        released: function(evt) {
            this.el.classList.remove('dragging');
        }
    };
})();