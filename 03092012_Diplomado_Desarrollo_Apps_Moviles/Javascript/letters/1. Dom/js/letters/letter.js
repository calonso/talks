(function() {
    LETTERS.Letter = function(source) {
        this.el = document.createElement('img');
        this.el.src = source;
    };
    
    LETTERS.Letter.prototype = {
        el: null   /** The HTML Element */
    };
})();