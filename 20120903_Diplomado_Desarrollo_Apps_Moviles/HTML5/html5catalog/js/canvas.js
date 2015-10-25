
$('#canvas').live('pageinit', function() {
    var context = $('#theCanvas')[0].getContext('2d');
    context.beginPath();
    context.rect(20, 20, 200, 100);
    var grd = context.createLinearGradient(20, 20, 220, 120);
    grd.addColorStop(0, '#8ED6FF');
    grd.addColorStop(1, '#004CB3');
    context.fillStyle = grd;
    context.fill();
    context.stroke();
    
    context.beginPath();
    context.arc(70, 200, 50, 0, 2 * Math.PI, false);
    grd = context.createLinearGradient(30, 150, 120, 250);
    grd.addColorStop(0, '#000000');
    grd.addColorStop(1, '#BC2920');
    context.fillStyle = grd;
    context.fill();
    context.stroke();
});