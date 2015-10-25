
(function(){
    GALLERY.MainPanel = function(htmlId) {
        var $div = $('#' + htmlId);
        if (!$div.size()) {
            $div = $('<div>', {id: htmlId});
            $(document.body).append($div);
        }
        this.$el = $div;
        this.images = [];
    };
    
    GALLERY.MainPanel.prototype = {
        $el: null,    /* HTML Element */
        images: null,
        
        loadImages: function(images) {
            var that = this;
            $.each(images, function() {
                that.addImage(new GALLERY.Pic(this));
            });
        },
        
        addImage: function(image) {
            this.images.push(image);
            this.$el.append(image.$el);
        }
    };
})();