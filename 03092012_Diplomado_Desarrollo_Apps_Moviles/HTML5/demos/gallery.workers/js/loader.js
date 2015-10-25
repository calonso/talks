
/*
 * Load jQuery
 * Get the url from the main thread, download the image and send it back
 */
onmessage = function(evt) {
    download(evt.data);
};

function download(url) {
    postMessage("Starting worker to:" + url);
    var req = new XMLHttpRequest();
    req.open('GET', url);
    req.onreadystatechange = function(evt) {
        if (this.readyState === 4 && this.status === 200) {
            postMessage(this.responseText);
        }
    };
    req.send();
}
