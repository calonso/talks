
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
        
        this.el.addEventListener('click', clickClosure, false);
        
        var self = this;
        function clickClosure(evt) {
            self.clicked(evt);
        }
    };
    
    LETTERS.Board.prototype = {
        el: null,    /* HTML Element */
        letters: null,
        
        loadLetters: function(images) {
            var self = this;
            images.forEach(function(img) {
                var letter = new LETTERS.Letter(img);
                self.letters.push(letter);
                self.el.appendChild(letter.el);
            });
        },
        
        clicked: function(evt) {
            var element = document.elementFromPoint(evt.clientX, evt.clientY);
            var clickedLetter = this.letters.filter(function(letter) {
                return letter.el == element;
            })[0];
            if (clickedLetter) {
                this.letters.forEach(function(letter) {
                    letter.el.setAttribute('style', 'border: none');
                });
                element.setAttribute('style', 'border:5px solid red');
            }
        }
    };
})();