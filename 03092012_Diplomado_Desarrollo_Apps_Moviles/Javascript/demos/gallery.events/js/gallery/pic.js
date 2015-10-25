(function() {
    GALLERY.Pic = function(source, index) {
        this.el = document.createElement('img');
        this.el.src = source;
        this.el.width = 200;
        this.el.addEventListener("mousedown", this.held, false);
        this.el.galleryObject = this;
        this.el.style.position = "absolute";
        this.el.style.top = "0px";
        this.el.style.left = this.el.width * index + "px";
    };
    
    GALLERY.Pic.prototype = {
        el: null,   /** The HTML Element */
        that: null,
        held: function(evt) {
            console.log("held");
            evt.preventDefault();
            document.movingElement = this.galleryObject;
            document.addEventListener("mousemove", this.galleryObject.moved, true);
            document.addEventListener("mouseup", this.galleryObject.released, true);
        },
        moved: function(evt) {
            console.log("moved");
            this.movingElement.el.style.left = evt.clientX + "px";
            this.movingElement.el.style.top = evt.clientY + "px";
            evt.stopPropagation();
        },
        released: function(evt) {
            console.log("released");
            document.removeEventListener("mousemove", document.movingElement.moved, true);
            document.removeEventListener("mouseup", document.movingElement.released, true);
            delete document.movingElement;
        }
    };
})();