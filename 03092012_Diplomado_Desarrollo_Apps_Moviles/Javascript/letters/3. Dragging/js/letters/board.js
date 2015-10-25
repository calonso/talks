
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
            for (var i = 0 ; i < images.length ; ++i) {
                var img = images[i];
                var letter = new LETTERS.Letter(img, i);
                this.letters.push(letter);
                this.el.appendChild(letter.el);
            }
        }
    };
})();