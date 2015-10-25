(function() {
    GALLERY.Pic = function(source, index) {
        this.el = document.createElement('img');
        this.el.src = source;
        this.el.width = 200;
        this.el.addEventListener("mousedown", this.held, false);
        this.el.galleryObject = this;
        this.el.style.position = "absolute";
        this.el.style.left = "0px";
        this.el.style.top = "0px";
        this.initialPosition = index * this.el.width;
        this.el.zIndex = GALLERY.IDLE_Z_INDEX;
    };
    
    GALLERY.Pic.prototype = {
        el: null,   /** The HTML Element */
        initialPosition: null,
        parent: null,
        held: function(evt) {
            evt.preventDefault();
            document.movingElement = this.galleryObject;
            this.style.zIndex = GALLERY.MOVING_Z_INDEX;
            document.addEventListener("mousemove", this.galleryObject.moved, true);
            document.addEventListener("mouseup", this.galleryObject.released, true);
        },
        moved: function(evt) {
            this.movingElement.el.style.left = evt.clientX + "px";
            evt.stopPropagation();
        },
        released: function(evt) {
            document.movingElement.el.style.zIndex = GALLERY.IDLE_Z_INDEX;
            document.removeEventListener("mousemove", document.movingElement.moved, true);
            document.removeEventListener("mouseup", document.movingElement.released, true);
            delete document.movingElement;
        },
        slide: function(oncomplete, index) {
            var start = (new Date()).getTime();
            var object = this;
            animate();
            
            function animate() {
                var elapsed = (new Date()).getTime() - start;
                if (elapsed < 1000) {
                    object.el.style.left = (object.initialPosition * elapsed / 1000) + "px";
                    setTimeout(animate, 1000 / 24);
                } else {
                    object.el.style.left = object.initialPosition + "px";
                    oncomplete.apply(object.parent, [index]);
                }
            }
        }
    };
})();