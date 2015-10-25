
var RACE = RACE || {};

(function(){
  "use strict";

  function Race(num_cars) {
    this.running_cars = num_cars;
    this.cars = [];
    this.ranking = new RACE.Ranking(); 
    for(var i = 0 ; i < num_cars ; ++i) {
      this.cars[i] = new RACE.Car(i);
    }

    var race = this;
    $('table').on('CAR_FINISHED', function(event, car_num) {
      race.add_finished(car_num);
    });
  }

  Race.prototype = {
    cars: null,
    winner: null,
    running_cars: 0,
    ranking: null,
    start: function() {
      $('table').trigger('RACE_START');
      $('table').table('refresh');
    },
    add_finished: function(car_num) {
      $('table').table('refresh');
      if(this.winner == null) {
        this.winner = car_num;
      }
      this.ranking.rank_car(car_num);

      var race = this;

      if(this.ranking.count() == this.running_cars) {
        $('#race_results p').html('RACE FINISHED. WINNER: ' + this.winner);
        $.mobile.changePage($("#race_results"), { transition: 'pop' });
        race.ranking.submit();
      }
    }
  };

  RACE.Race = Race;

})();