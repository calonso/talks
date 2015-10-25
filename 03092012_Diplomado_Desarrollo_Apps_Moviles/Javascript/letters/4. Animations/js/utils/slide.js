
function slide(element, target, duration, oncomplete) {
    var xInterval = target.x - element.getBoundingClientRect().left;
    var yInterval = target.y - element.getBoundingClientRect().top;
    
    var start = (new Date()).getTime();
    
    var css = window.getComputedStyle(element, null);
    var initialPosition = { x: parseInt(css.left), y: parseInt(css.top) };
    animate();
    
    function animate() {
        var elapsed = (new Date()).getTime() - start;
        
        if (elapsed < duration) {
            var deltaX = xInterval * (elapsed / duration);
            var deltaY = yInterval * (elapsed / duration);
            
            element.style.left = (initialPosition.x + deltaX) + "px";
            element.style.top = (initialPosition.y + deltaY) + "px";

            setTimeout(animate, 1000 / 24);
        } else {
            element.style.left = target.x;
            element.style.top = target.y;
            oncomplete();
        }
    }
}
