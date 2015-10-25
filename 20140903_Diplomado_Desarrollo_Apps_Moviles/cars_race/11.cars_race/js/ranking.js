
(function(){
  "use strict";
  
  function Ranking() {
    this.ranking = [];
  }

  Ranking.prototype = {
    ranking: null,
    rank_car: function(car) {
      this.ranking.push(car);
    },
    count: function() {
      return this.ranking.length;
    },
    submit: function() {
      var self = this;
      $.ajax({
        url: 'http://interlat-racing.herokuapp.com/ranking',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ ranking: this.ranking }),
        error: function(data, textStatus, jqXHR) {
          alert('ERROR Submitting the ranking! ' + data.error);
        },
        success: function(data, textStatus, jqXHR ) {
          self.get();
        }
      });
    },
    get: function() {
      $.ajax({
        url: 'http://interlat-racing.herokuapp.com/ranking',
        success: function(data, textStatus, jqXHR) {
          var list = $('#ranking ol');

          $.each(data, function(index, object){
            var item = $('<li></li>', { html: 'Car: ' + object.car + ' Score: ' + object.score });
            list.append(item);
          });
          $.mobile.changePage($("#ranking"));
        }
      });
    }
  };

  RACE.Ranking = Ranking
})();