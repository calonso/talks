
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
        }
    };
})();