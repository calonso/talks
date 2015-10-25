/**
 * Namespace
 */
var VIEWER = VIEWER || {};

(function(){
    VIEWER.storage = localStorage;
    
    VIEWER.Viewer = function(htmlId) {
        var $div = $('#' + htmlId);
        if (!$div.size()) {
            $div = $('<div>', {id: htmlId});
            $(document.body).append($div);
        }
        this.$el = $div;
        this.reload();
    };
    
    VIEWER.Viewer.prototype = {
        $el: null,
        data: null,
        addItem: function(key, value) {
            VIEWER.storage[key] = value;
            this.reload();
        },
        reload: function() {
            this.data = $.map(Object.keys(VIEWER.storage), function(val, i) {
                return {key: val, value: VIEWER.storage[val]};
            });
            this.refresh();
        },
        refresh: function() {
            this.$el.empty();
            var $container = this.$el;
            $.each(this.data, function(index, value) {
                var $p = $('<p>').text(index + ': ' + value.key + " -> " + value.value);
                $container.append($p);
            });
        }
    }
})();