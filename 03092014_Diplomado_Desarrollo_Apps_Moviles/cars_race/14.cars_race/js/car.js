
(function(){
  "use strict";

  function Car(number) {
    this.number = number;
    this.$row = $('<tr></tr>', { html: '<td>' + number + '</td><td>IDLE</td>'});
    $('table tbody').append(this.$row);

    var car = this;
    $('table').on('RACE_START', function() {
      car.run();
    });
  }

  Car.prototype = {
    number: null,
    $row: null,
    run: function() {
      this.$row.find('td:last').html('RUNNING');
      var car = this;
      setTimeout(function() {
        car.finish();
      }, Math.random() * 5000);
    },
    finish: function() {
      this.$row.find('td:last').html('FINISHED');
      $('table').trigger('CAR_FINISHED', [this.number]);
    }
  };

  RACE.Car = Car;
  
})();