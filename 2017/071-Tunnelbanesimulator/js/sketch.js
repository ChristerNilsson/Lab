// Generated by CoffeeScript 1.11.1
var DT, LENGTH, MAX_ACC, MAX_SPEED, R, Station, Train, X, Y, draw, mousePressed, pause, setup, stations, trains,
  modulo = function(a, b) { return (+a % (b = +b) + b) % b; };

X = 420;

Y = 420;

R = 400;

MAX_SPEED = 4;

MAX_ACC = 1;

LENGTH = 5;

DT = 0.02;

trains = [];

stations = [];

pause = false;

Station = (function() {
  function Station(angle, duration) {
    this.angle = angle;
    this.duration = duration;
  }

  Station.prototype.draw = function() {
    var start, stopp;
    start = radians(this.angle - LENGTH);
    stopp = radians(this.angle);
    fc();
    sc(0.5);
    sw(5);
    return arc(X, Y, 2 * R, 2 * R, start, stopp);
  };

  return Station;

})();

Train = (function() {
  function Train(angle, r, g, b1, nextStation, nextTrain, maxSpeed, maxAcc, duration) {
    this.angle = angle;
    this.r = r;
    this.g = g;
    this.b = b1;
    this.nextStation = nextStation;
    this.nextTrain = nextTrain;
    this.maxSpeed = maxSpeed != null ? maxSpeed : MAX_SPEED;
    this.maxAcc = maxAcc != null ? maxAcc : MAX_ACC;
    this.duration = duration != null ? duration : 10000;
    this.state = 'Run';
    this.speed = 0;
    this.acc = this.maxAcc;
    this.nextStart = millis();
  }

  Train.prototype.dump = function(txt, value, x, y) {
    if (this.nr === -1) {
      sc();
      fc(1);
      return text(txt + ' ' + value, x, y);
    }
  };

  Train.prototype.update = function(nr) {
    var a, b, checkStation, checkTrain, ds, dt, s, t;
    checkStation = (function(_this) {
      return function() {
        var acc;
        if (ds - 20 < s) {
          if (ds < 0.1) {
            acc = 0;
            _this.speed = 0;
            _this.nextStart = millis() + _this.duration;
            _this.state = 'Stop';
          } else if (ds > 5) {
            acc = _this.maxAcc;
          } else {
            acc = -_this.maxAcc;
          }
        } else {
          acc = _this.maxAcc;
        }
        return acc;
      };
    })(this);
    checkTrain = (function(_this) {
      return function() {
        if (dt - 12 < s) {
          return -_this.maxAcc;
        } else {
          return _this.maxAcc;
        }
      };
    })(this);
    this.nr = nr;
    t = this.maxSpeed / this.maxAcc;
    s = this.maxAcc * t * t / 2;
    dt = trains[this.nextTrain].angle - this.angle;
    ds = stations[this.nextStation].angle - this.angle;
    if (dt < 0) {
      dt += 360;
    }
    if (ds < 0) {
      ds += 360;
    }
    if (this.state === 'Run') {
      a = checkStation();
      b = checkTrain();
      this.acc = _.min([a, b]);
    } else {
      this.acc = 0;
      if (millis() > this.nextStart) {
        this.nextStation = (this.nextStation + 1) % stations.length;
        this.state = 'Run';
        this.acc = this.maxAcc;
      }
    }
    if (nr === 0) {
      this.dump('t', nf(t, 0, 1), 400, 100);
      this.dump('s', nf(s, 0, 1), 400, 125);
      this.dump('dt', round(dt), 400, 150);
      this.dump('ds', round(ds), 400, 175);
    }
    if (pause) {
      return;
    }
    this.speed += this.acc * DT;
    if (this.speed > this.maxSpeed) {
      this.acc = 0;
      this.speed = this.maxSpeed;
    }
    if (this.speed < 0) {
      this.speed = 0;
    }
    return this.angle = modulo(this.angle + this.speed * DT, 360);
  };

  Train.prototype.draw = function(nr) {
    var start, stopp, y;
    this.update(nr);
    start = radians(this.angle - LENGTH);
    stopp = radians(this.angle);
    fc();
    sc(this.r, this.g, this.b);
    sw(5);
    arc(X, Y, 2 * R, 2 * R, start, stopp);
    fc(this.r, this.g, this.b);
    y = 300 + 30 * nr;
    sc();
    text(this.state, 200, y);
    text(nf(this.acc, 0, 1), 300, y);
    text(round(this.angle), 400, y);
    text(nf(this.speed, 0, 1), 500, y);
    if (this.nextStart > millis()) {
      text(round((this.nextStart - millis()) / 1000), 600, y);
    }
    return text(this.nextStation, 700, y);
  };

  return Train;

})();

setup = function() {
  createCanvas(2 * X + 40, 2 * Y + 40);
  textSize(20);
  textAlign(RIGHT);
  frameRate(50);
  stations.push(new Station(50, 60));
  stations.push(new Station(101, 60));
  stations.push(new Station(183, 60));
  stations.push(new Station(224, 60));
  stations.push(new Station(337, 60));
  trains.push(new Train(0, 1, 0, 0, 0, 1, MAX_SPEED * 1.5, MAX_ACC * 1.1, 5000));
  trains.push(new Train(70, 1, 1, 0, 1, 2));
  trains.push(new Train(140, 0, 1, 0, 2, 3));
  trains.push(new Train(211, 0, 1, 1, 3, 4));
  return trains.push(new Train(300, 1, 0, 1, 4, 0));
};

draw = function() {
  var i, j, k, len, len1, results, station, train, y;
  bg(1);
  sc(0);
  sw(4);
  fill(0);
  circle(X, Y, R + 10);
  y = 270;
  fc(1);
  sc();
  sw(0);
  text('state', 200, y);
  text('acc', 300, y);
  text('angle', 400, y);
  text('speed', 500, y);
  text('sec', 600, y);
  text('next', 700, y);
  for (j = 0, len = stations.length; j < len; j++) {
    station = stations[j];
    station.draw();
  }
  results = [];
  for (i = k = 0, len1 = trains.length; k < len1; i = ++k) {
    train = trains[i];
    results.push(train.draw(i));
  }
  return results;
};

mousePressed = function() {
  return pause = !pause;
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsMkdBQUE7RUFBQTs7QUFBQSxDQUFBLEdBQUk7O0FBQ0osQ0FBQSxHQUFJOztBQUNKLENBQUEsR0FBSTs7QUFDSixTQUFBLEdBQVk7O0FBQ1osT0FBQSxHQUFZOztBQUNaLE1BQUEsR0FBWTs7QUFDWixFQUFBLEdBQVM7O0FBRVQsTUFBQSxHQUFTOztBQUNULFFBQUEsR0FBVzs7QUFFWCxLQUFBLEdBQVE7O0FBRUY7RUFDUyxpQkFBQyxLQUFELEVBQVEsUUFBUjtJQUFDLElBQUMsQ0FBQSxRQUFEO0lBQU8sSUFBQyxDQUFBLFdBQUQ7RUFBUjs7b0JBQ2QsSUFBQSxHQUFPLFNBQUE7QUFDTixRQUFBO0lBQUEsS0FBQSxHQUFRLE9BQUEsQ0FBUSxJQUFDLENBQUEsS0FBRCxHQUFTLE1BQWpCO0lBQ1IsS0FBQSxHQUFRLE9BQUEsQ0FBUSxJQUFDLENBQUEsS0FBVDtJQUNSLEVBQUEsQ0FBQTtJQUNBLEVBQUEsQ0FBRyxHQUFIO0lBQ0EsRUFBQSxDQUFHLENBQUg7V0FDQSxHQUFBLENBQUksQ0FBSixFQUFNLENBQU4sRUFBUSxDQUFBLEdBQUUsQ0FBVixFQUFZLENBQUEsR0FBRSxDQUFkLEVBQWdCLEtBQWhCLEVBQXNCLEtBQXRCO0VBTk07Ozs7OztBQVFGO0VBQ1MsZUFBQyxLQUFELEVBQVMsQ0FBVCxFQUFZLENBQVosRUFBZSxFQUFmLEVBQW1CLFdBQW5CLEVBQWlDLFNBQWpDLEVBQTZDLFFBQTdDLEVBQWtFLE1BQWxFLEVBQW1GLFFBQW5GO0lBQUMsSUFBQyxDQUFBLFFBQUQ7SUFBUSxJQUFDLENBQUEsSUFBRDtJQUFHLElBQUMsQ0FBQSxJQUFEO0lBQUcsSUFBQyxDQUFBLElBQUQ7SUFBSSxJQUFDLENBQUEsY0FBRDtJQUFjLElBQUMsQ0FBQSxZQUFEO0lBQVksSUFBQyxDQUFBLDhCQUFE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YSxDQUFiLEVBQWUsQ0FBZixFQUFrQixDQUFsQixFQUFvQixDQUFwQixDQUFoQjtBQWhCTzs7QUFrQlIsSUFBQSxHQUFPLFNBQUE7QUFDTixNQUFBO0VBQUEsRUFBQSxDQUFHLENBQUg7RUFDQSxFQUFBLENBQUcsQ0FBSDtFQUNBLEVBQUEsQ0FBRyxDQUFIO0VBQ0EsSUFBQSxDQUFLLENBQUw7RUFDQSxNQUFBLENBQU8sQ0FBUCxFQUFTLENBQVQsRUFBVyxDQUFBLEdBQUUsRUFBYjtFQUVBLENBQUEsR0FBSTtFQUNKLEVBQUEsQ0FBRyxDQUFIO0VBQ0EsRUFBQSxDQUFBO0VBQ0EsRUFBQSxDQUFHLENBQUg7RUFDQSxJQUFBLENBQUssT0FBTCxFQUFjLEdBQWQsRUFBa0IsQ0FBbEI7RUFDQSxJQUFBLENBQUssS0FBTCxFQUFjLEdBQWQsRUFBa0IsQ0FBbEI7RUFDQSxJQUFBLENBQUssT0FBTCxFQUFjLEdBQWQsRUFBa0IsQ0FBbEI7RUFDQSxJQUFBLENBQUssT0FBTCxFQUFjLEdBQWQsRUFBa0IsQ0FBbEI7RUFDQSxJQUFBLENBQUssS0FBTCxFQUFjLEdBQWQsRUFBa0IsQ0FBbEI7RUFDQSxJQUFBLENBQUssTUFBTCxFQUFjLEdBQWQsRUFBa0IsQ0FBbEI7QUFFQSxPQUFBLDBDQUFBOztJQUFBLE9BQU8sQ0FBQyxJQUFSLENBQUE7QUFBQTtBQUNBO09BQUEsa0RBQUE7O2lCQUFBLEtBQUssQ0FBQyxJQUFOLENBQVcsQ0FBWDtBQUFBOztBQW5CTTs7QUFzQlAsWUFBQSxHQUFlLFNBQUE7U0FDZCxLQUFBLEdBQVEsQ0FBSTtBQURFIiwic291cmNlc0NvbnRlbnQiOlsiWCA9IDQyMFxyXG5ZID0gNDIwXHJcblIgPSA0MDBcclxuTUFYX1NQRUVEID0gNCAjIGdyYWRlci9zXHJcbk1BWF9BQ0MgICA9IDEgIyBncmFkZXIvczJcclxuTEVOR1RIICAgID0gNSAjIGdyYWRlclxyXG5EVCAgICAgPSAwLjAyICMgbXNcclxuXHJcbnRyYWlucyA9IFtdXHJcbnN0YXRpb25zID0gW11cclxuXHJcbnBhdXNlID0gZmFsc2VcclxuXHJcbmNsYXNzIFN0YXRpb25cclxuXHRjb25zdHJ1Y3RvciA6IChAYW5nbGUsQGR1cmF0aW9uKSAtPlxyXG5cdGRyYXcgOiAtPlxyXG5cdFx0c3RhcnQgPSByYWRpYW5zIEBhbmdsZSAtIExFTkdUSFxyXG5cdFx0c3RvcHAgPSByYWRpYW5zIEBhbmdsZVxyXG5cdFx0ZmMoKVxyXG5cdFx0c2MgMC41XHJcblx0XHRzdyA1XHJcblx0XHRhcmMgWCxZLDIqUiwyKlIsc3RhcnQsc3RvcHBcclxuXHJcbmNsYXNzIFRyYWluXHJcblx0Y29uc3RydWN0b3IgOiAoQGFuZ2xlLCBAcixAZyxAYiwgQG5leHRTdGF0aW9uLCBAbmV4dFRyYWluLCBAbWF4U3BlZWQ9TUFYX1NQRUVELCBAbWF4QWNjPU1BWF9BQ0MsIEBkdXJhdGlvbj0xMDAwMCkgLT5cclxuXHRcdEBzdGF0ZSA9ICdSdW4nICMgU3RvcCBSdW5cclxuXHRcdEBzcGVlZCA9IDBcclxuXHRcdEBhY2MgPSBAbWF4QWNjXHJcblx0XHRAbmV4dFN0YXJ0ID0gbWlsbGlzKClcclxuXHJcblx0ZHVtcCA6ICh0eHQsdmFsdWUseCx5KSAtPlxyXG5cdFx0aWYgQG5yID09IC0xXHJcblx0XHRcdHNjKClcclxuXHRcdFx0ZmMgMVxyXG5cdFx0XHR0ZXh0IHR4dCArICcgJyArIHZhbHVlLHgseVxyXG5cclxuXHR1cGRhdGUgOiAobnIpIC0+XHJcblxyXG5cdFx0Y2hlY2tTdGF0aW9uID0gPT5cclxuXHRcdFx0aWYgZHMgLSAyMCA8IHNcclxuXHRcdFx0XHRpZiBkcyA8IDAuMSAjcGVycm9uZ3N0b3BwXHJcblx0XHRcdFx0XHRhY2MgPSAwXHJcblx0XHRcdFx0XHRAc3BlZWQgPSAwXHJcblx0XHRcdFx0XHRAbmV4dFN0YXJ0ID0gbWlsbGlzKCkgKyBAZHVyYXRpb25cclxuXHRcdFx0XHRcdEBzdGF0ZSA9ICdTdG9wJ1xyXG5cdFx0XHRcdGVsc2UgaWYgZHMgPiA1XHJcblx0XHRcdFx0XHRhY2MgPSBAbWF4QWNjXHJcblx0XHRcdFx0ZWxzZSAjIG1pbnNrYSBoYXN0aWdoZXRlbiBub3JtYWx0XHJcblx0XHRcdFx0XHRhY2MgPSAtQG1heEFjY1xyXG5cdFx0XHRlbHNlXHJcblx0XHRcdFx0YWNjID0gQG1heEFjY1xyXG5cclxuXHRcdFx0YWNjXHJcblxyXG5cdFx0Y2hlY2tUcmFpbiA9ID0+IGlmIGR0IC0gMTIgPCBzIHRoZW4gLUBtYXhBY2MgZWxzZSBAbWF4QWNjXHJcblxyXG5cdFx0QG5yID0gbnJcclxuXHRcdHQgPSBAbWF4U3BlZWQvQG1heEFjYyAjIDRcclxuXHRcdHMgPSBAbWF4QWNjICogdCp0IC8gMiAjIDhcclxuXHRcdGR0ID0gdHJhaW5zW0BuZXh0VHJhaW5dLmFuZ2xlIC0gQGFuZ2xlXHJcblx0XHRkcyA9IHN0YXRpb25zW0BuZXh0U3RhdGlvbl0uYW5nbGUgLSBAYW5nbGVcclxuXHJcblx0XHRpZiBkdDwwIHRoZW4gZHQgKz0gMzYwXHJcblx0XHRpZiBkczwwIHRoZW4gZHMgKz0gMzYwXHJcblxyXG5cdFx0aWYgQHN0YXRlPT0nUnVuJ1xyXG5cdFx0XHRhID0gY2hlY2tTdGF0aW9uKClcclxuXHRcdFx0YiA9IGNoZWNrVHJhaW4oKVxyXG5cdFx0XHRAYWNjID0gXy5taW4gW2EsYl1cclxuXHRcdGVsc2VcclxuXHRcdFx0QGFjYyA9IDBcclxuXHRcdFx0aWYgbWlsbGlzKCkgPiBAbmV4dFN0YXJ0XHJcblx0XHRcdFx0QG5leHRTdGF0aW9uID0gKEBuZXh0U3RhdGlvbiArIDEpICUgc3RhdGlvbnMubGVuZ3RoXHJcblx0XHRcdFx0QHN0YXRlID0gJ1J1bidcclxuXHRcdFx0XHRAYWNjID0gQG1heEFjY1xyXG5cclxuXHRcdGlmIG5yPT0wXHJcblx0XHRcdEBkdW1wICd0JywgbmYodCwwLDEpLDQwMCwxMDBcclxuXHRcdFx0QGR1bXAgJ3MnLCBuZihzLDAsMSksNDAwLDEyNVxyXG5cdFx0XHRAZHVtcCAnZHQnLHJvdW5kKGR0KSw0MDAsMTUwXHJcblx0XHRcdEBkdW1wICdkcycscm91bmQoZHMpLDQwMCwxNzVcclxuXHRcdGlmIHBhdXNlIHRoZW4gcmV0dXJuXHJcblxyXG5cdFx0QHNwZWVkICs9IEBhY2MgKiBEVFxyXG5cdFx0aWYgQHNwZWVkID4gQG1heFNwZWVkXHJcblx0XHRcdEBhY2M9MFxyXG5cdFx0XHRAc3BlZWQgPSBAbWF4U3BlZWRcclxuXHRcdGlmIEBzcGVlZCA8IDAgdGhlbiBAc3BlZWQgPSAwXHJcblx0XHRAYW5nbGUgPSAoQGFuZ2xlICsgQHNwZWVkKkRUKSAlJSAzNjBcclxuXHJcblx0ZHJhdyA6IChucikgLT5cclxuXHRcdEB1cGRhdGUgbnJcclxuXHRcdHN0YXJ0ID0gcmFkaWFucyBAYW5nbGUgLSBMRU5HVEhcclxuXHRcdHN0b3BwID0gcmFkaWFucyBAYW5nbGVcclxuXHRcdGZjKClcclxuXHRcdHNjIEByLEBnLEBiXHJcblx0XHRzdyA1XHJcblx0XHRhcmMgWCxZLDIqUiwyKlIsc3RhcnQsc3RvcHBcclxuXHRcdGZjIEByLEBnLEBiXHJcblx0XHR5ID0gMzAwKzMwKm5yXHJcblx0XHRzYygpXHJcblx0XHR0ZXh0IEBzdGF0ZSwgMjAwLHlcclxuXHRcdHRleHQgbmYoQGFjYywwLDEpLCAzMDAseVxyXG5cdFx0dGV4dCByb3VuZChAYW5nbGUpLCA0MDAseVxyXG5cdFx0dGV4dCBuZihAc3BlZWQsMCwxKSwgNTAwLHlcclxuXHRcdGlmIEBuZXh0U3RhcnQgPiBtaWxsaXMoKSB0aGVuIHRleHQgcm91bmQoKEBuZXh0U3RhcnQgLSBtaWxsaXMoKSkvMTAwMCksIDYwMCx5XHJcblx0XHR0ZXh0IEBuZXh0U3RhdGlvbiwgNzAwLHlcclxuXHJcbnNldHVwID0gLT5cclxuXHRjcmVhdGVDYW52YXMgMipYKzQwLDIqWSs0MFxyXG5cdHRleHRTaXplIDIwXHJcblx0dGV4dEFsaWduIFJJR0hUXHJcblx0ZnJhbWVSYXRlIDUwXHJcblxyXG5cdHN0YXRpb25zLnB1c2ggbmV3IFN0YXRpb24gNTAsNjBcclxuXHRzdGF0aW9ucy5wdXNoIG5ldyBTdGF0aW9uIDEwMSw2MFxyXG5cdHN0YXRpb25zLnB1c2ggbmV3IFN0YXRpb24gMTgzLDYwXHJcblx0c3RhdGlvbnMucHVzaCBuZXcgU3RhdGlvbiAyMjQsNjBcclxuXHRzdGF0aW9ucy5wdXNoIG5ldyBTdGF0aW9uIDMzNyw2MFxyXG5cclxuXHR0cmFpbnMucHVzaCBuZXcgVHJhaW4gICAwLCAxLDAsMCwgMCwxLCBNQVhfU1BFRUQqMS41LCBNQVhfQUNDKjEuMSwgNTAwMFxyXG5cdHRyYWlucy5wdXNoIG5ldyBUcmFpbiAgNzAsIDEsMSwwLCAxLDJcclxuXHR0cmFpbnMucHVzaCBuZXcgVHJhaW4gMTQwLCAwLDEsMCwgMiwzXHJcblx0dHJhaW5zLnB1c2ggbmV3IFRyYWluIDIxMSwgMCwxLDEsIDMsNFxyXG5cdHRyYWlucy5wdXNoIG5ldyBUcmFpbiAzMDAsIDEsMCwxLCA0LDBcclxuXHJcbmRyYXcgPSAtPlxyXG5cdGJnIDFcclxuXHRzYyAwXHJcblx0c3cgNFxyXG5cdGZpbGwgMFxyXG5cdGNpcmNsZSBYLFksUisxMFxyXG5cclxuXHR5ID0gMjcwXHJcblx0ZmMgMVxyXG5cdHNjKClcclxuXHRzdyAwXHJcblx0dGV4dCAnc3RhdGUnLCAyMDAseVxyXG5cdHRleHQgJ2FjYycsICAgMzAwLHlcclxuXHR0ZXh0ICdhbmdsZScsIDQwMCx5XHJcblx0dGV4dCAnc3BlZWQnLCA1MDAseVxyXG5cdHRleHQgJ3NlYycsICAgNjAwLHlcclxuXHR0ZXh0ICduZXh0JywgIDcwMCx5XHJcblxyXG5cdHN0YXRpb24uZHJhdygpIGZvciBzdGF0aW9uIGluIHN0YXRpb25zXHJcblx0dHJhaW4uZHJhdyBpIGZvciB0cmFpbixpIGluIHRyYWluc1xyXG5cdCNwcmludCBmcmFtZVJhdGUoKVxyXG5cclxubW91c2VQcmVzc2VkID0gLT5cclxuXHRwYXVzZSA9IG5vdCBwYXVzZSJdfQ==
//# sourceURL=C:\Lab\2017\071-Tunnelbanesimulator\coffee\sketch.coffee