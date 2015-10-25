(function() {
    LETTERS.Letter = function(source, board) {
        this.el = document.createElement('img');
        this.el.src = source;
        
        this.el.classList.add('letter');
        
        this.el.addEventListener('mousedown', clickClosure, false);
        
        var self = this;
        function clickClosure(evt) {
            self.clicked(evt);
        }
        
        this.board = board;
    };
    
    LETTERS.Letter.prototype = {
        el: null,   /** The HTML Element */
        board: null,
        
        clicked: function(evt) {
            this.el.classList.add('dragging');
            var self = this;
            drag(this.el, evt, function(evt) {
                self.released(evt);
                });
        },
        
        released: function(evt) {
            this.el.classList.remove('dragging');
            this.board.letterDropped(this, evt);
        }
    };
})();