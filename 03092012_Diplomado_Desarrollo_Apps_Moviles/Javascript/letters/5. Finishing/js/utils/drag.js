
function drag(element, evt, releasedHandler) {
    var scrollX = window.pageXOffset;
    var scrollY = window.pageYOffset;
    
    var startX = evt.clientX + scrollX;
    var startY = evt.clientY + scrollY;
    
    var origX = element.offsetLeft;
    var origY = element.offsetTop;
    
    var deltaX = startX - origX;
    var deltaY = startY - origY;
    
    document.addEventListener("mousemove", moveHandler, true);
    document.addEventListener("mouseup", upHandler, true);
    
    evt.preventDefault();
    
    function moveHandler(e) {
        var scrollX = window.pageXOffset;
        var scrollY = window.pageYOffset;
        
        element.style.left = (e.clientX + scrollX - deltaX) + "px";
        element.style.top = (e.clientY + scrollY - deltaY) + "px";
        
        e.stopPropagation();
    }
    
    function upHandler(e) {
        document.removeEventListener("mousemove", moveHandler, true);
        document.removeEventListener("mouseup", upHandler, true);
        e.stopPropagation();
        releasedHandler(e);
    }
}