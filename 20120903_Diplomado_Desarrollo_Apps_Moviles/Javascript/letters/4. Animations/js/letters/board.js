
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
                var letter = new LETTERS.Letter(img);
                this.letters.push(letter);
                this.el.appendChild(letter.el);
                var css =  window.getComputedStyle(letter.el, null);
                slide(letter.el, { x: parseInt(css.width) * i, y: parseInt(css.top) }, 1000, function() {});
            }
        }
    };
})();