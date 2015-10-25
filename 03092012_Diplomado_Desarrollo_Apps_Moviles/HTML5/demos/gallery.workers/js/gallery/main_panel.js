
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
        
        loadAsync: function() {
            var panel = this;
            $.getJSON(GALLERY.IMAGES_SERVER_URL, function(data) {
                $.each(data, function(index, value){
                    var worker = new Worker('js/loader.js');
                    worker.postMessage(value.url);
                    worker.onmessage = function(evt) {
                        console.log("From worker: " + evt.data);
                        if (evt.data === "string") {
                            console.log("From worker: " + evt.data);
                        } else {
                            panel.addImage(new GALLERY.Pic(evt.data));
                        }
                    };
                });
            });
        },
        
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