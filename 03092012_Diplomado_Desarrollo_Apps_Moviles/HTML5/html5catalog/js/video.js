
(function(){
    $('#video').live('pageinit', function(){
        var player = $('#theVideo');
        var status = $('#status');
        player.bind('loadStart', function(event) { status.val("Loading..."); });
        player.bind('loadedmetadata', function(event) { status.val("Received Metadata"); });
        player.bind('playing', function(event) { status.val("Playing"); });
        player.bind('pause', function(event) { status.val("Paused"); });
        player.bind('ended', function(event) { status.val("Ended"); });
        player.bind('error', function(event) { status.val("Error"); });
        
        $('#play_btn').bind('click', function() {
            var video = $('#theVideo').get(0);
            var playables = VIDEO_RESOURCES.filter(function(videoObj) {
                return video.canPlayType(videoObj.type);
            });
            
            if (playables.length) {
                video.src = playables[0].path;
                video.load();
                video.play();
            } else {
                alert("No compatible video format provided!");
            }
        });
    });
    
    var VIDEO_RESOURCES = [
        { type: 'video/mp4', path: '/html5catalog/resources/141.mp4' },
        { type: 'video/webm', path: '/html5catalog/resources/movements_ES.webm' },
        { type: 'video/ogg', path: '/html5catalog/resources/movements_ES.ogg' }
    ];
})();
