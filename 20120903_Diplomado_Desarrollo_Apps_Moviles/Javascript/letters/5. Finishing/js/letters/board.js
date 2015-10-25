
(function(){
    LETTERS.Board = function(htmlId) {
        var div = document.getElementById('#' + htmlId);
        if (!div) {
            div = document.createElement('div');
            div.id = htmlId;
            document.body.appendChild(div);
        }
        this.el = div;
        this.letters = [];
        this.decks = [];
    };
    
    LETTERS.Board.prototype = {
        el: null,    /* HTML Element */
        letters: null,
        decks: null,
        
        loadLetters: function(images) {
            for (var i = 0 ; i < images.length ; ++i) {
                var img = images[i];
                var letter = new LETTERS.Letter(img, this);
                this.letters.push(letter);
                this.el.appendChild(letter.el);
                
                var deck = new LETTERS.Deck(img, this);
                var deckCss =  window.getComputedStyle(deck.el, null);
                var deckWidth = parseInt(deckCss.width) + parseInt(deckCss.borderLeftWidth) + parseInt(deckCss.borderRightWidth);
                deck.el.style.left = (i * deckWidth) + "px";
                this.el.appendChild(deck.el);
                this.decks.push(deck);
                
                var letCss = window.getComputedStyle(letter.el, null);
                var left = parseInt(deckWidth) * 2;
                var top = parseInt(deckWidth);
                slide(letter.el, { x: left, y: top }, 1000, function() {});
            }
        },
        
        letterDropped: function(letter, evt) {
            this.decks.forEach(function(deck) {
                var r = deck.el.getBoundingClientRect();
                if (evt.clientX > r.left && evt.clientX < r.left + r.width
                    && evt.clientY > r.top && evt.clientY < r.top + r.height) {
                    var deckCss =  window.getComputedStyle(deck.el, null);
                    var deckWidth = parseInt(deckCss.width) + parseInt(deckCss.borderLeftWidth) + parseInt(deckCss.borderRightWidth);
                    
                    var letCss = window.getComputedStyle(letter.el, null);
                    var left = parseInt(deckCss.left) + parseInt(((deckWidth - parseInt(letCss.width)) / 2).toFixed(0));
                    var top = (parseInt(deckWidth) - parseInt(letCss.height)) / 2;
                    slide(letter.el, { x: left, y: top }, 1000, function() {
                        deck.dropped(letter);
                    });
                }
            });
        },
        
        checkGameFinished: function() {
            var finished = true;
            this.decks.forEach(function(deck) {
                finished = finished && deck.containsRightLetter();
            });
            if (finished) {
                alert("GAME FINISHED");
            }
        }
    };
})();