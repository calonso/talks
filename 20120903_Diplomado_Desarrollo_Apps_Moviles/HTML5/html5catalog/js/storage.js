
(function(){
    $('#storage').live('pageinit', function(){
        refreshList();
        
        $('#add_btn').bind('click', function() {
            var $input = $('#item');
            if (!$input.val()) {
                alert("You have to add some text!");
            } else {
                var arr = localStorage.items ? JSON.parse(localStorage.items) : [];
                arr.push($input.val());
                localStorage.items = JSON.stringify(arr);
            }
            refreshList();
        });
    });
    
    function refreshList() {
        var $list = $("#storage ol:jqmData(role=listview)").empty();
        var arr = localStorage.items ? JSON.parse(localStorage.items) : [];
        if (arr.length) {
            $.each(arr, function(index, value) {
                var $li = $('<li>').text(value);
                $list.append($li);
            });
        }
        $list.listview("refresh");
    }
})();
