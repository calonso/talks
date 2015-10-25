
(function(){
    LETTERS.Deck = function(expectedLetter, board) {
        this.el = document.createElement('div');
        this.el.classList.add('deck');
        this.board = board;
        this.expectedLetter = expectedLetter;
    };
    
    LETTERS.Deck.prototype = {
        el: null,
        board: null,
        expectedLetter: null,
        storedLetter: null,
        
        dropped: function(letter) {
            this.storedLetter = letter.el.src;
            if (this.containsRightLetter()) {
                this.board.checkGameFinished();
            }
        },
        
        containsRightLetter: function() {
            return this.storedLetter && this.storedLetter.search(this.expectedLetter) != -1;
        }
    };
})();