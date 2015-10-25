
(function(){
    GALLERY.MainPanel = function(htmlId) {
        var div = document.getElementById(htmlId);
        if (!div) {
            div = document.createElement('div');
            div.id = htmlId;
            document.body.appendChild(div);
        }
        this.el = div;
        this.images = [];
    };
    
    GALLERY.MainPanel.prototype = {
        el: null,    /* HTML Element */
        images: null,
        
        loadImages: function(images) {
            for (var i = 0 ; i < images.length ; ++i) {
                var img = images[i];
                this.addImage(new GALLERY.Pic(img, i));
            }
            this.animateNext(0);
        },
        
        addImage: function(image) {
            this.images.push(image);
            image.parent = this;
            this.el.appendChild(image.el);
        },
        
        animateNext: function(index) {
            if (index < this.images.length) {
                this.images[index].slide(this.animateNext, index+1);
            }
        }
    };
})();