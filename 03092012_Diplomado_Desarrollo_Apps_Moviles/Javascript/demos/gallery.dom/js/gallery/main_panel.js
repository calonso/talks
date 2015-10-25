
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
            var that = this;
            images.forEach(function(img) {
                that.addImage(new GALLERY.Pic(img));
            });
        },
        
        addImage: function(image) {
            this.images.push(image);
            this.el.appendChild(image.el);
        }
    };
})();