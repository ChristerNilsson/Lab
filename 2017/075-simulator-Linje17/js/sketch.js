// Generated by CoffeeScript 1.11.1
var ASegment, BSegment, DT, DURATION, FACTOR, LENGTH, MACC, MAX_ACC, MAX_SPEED, MLEN, MM, MSPEED, MTOTAL, MWIDTH, Station, Train, WIDTH, X0, Y0, changeScale, corr, draw, drawLine, drawLine2, factor, getPoint, memory, midPoint, mouseDragged, mousePressed, names, pause, ref, segments, setup, stations, totalDist, trains,
  modulo = function(a, b) { return (+a % (b = +b) + b) % b; };

MSPEED = 25;

MACC = 1.25;

MLEN = 3 * 46.5;

MWIDTH = 3;

MTOTAL = 2 * 19600;

DURATION = 30;

FACTOR = 24.3;

MM = 0.001 / FACTOR;

MAX_SPEED = MSPEED / FACTOR;

MAX_ACC = MACC / FACTOR;

LENGTH = MLEN / FACTOR;

WIDTH = MWIDTH / FACTOR;

DT = 0.02;

names = 'Åkeshov Brommaplan Abrahamsberg StoraMossen Alvik Kristineberg Thorildsplan Fridhemsplan S:tEriksplan Odenplan Rådmansgatan Hötorget T-centralen GamlaStan Slussen Medborgarplatsen Skanstull Gullmarsplan Skärmarbrink Hammarbyhöjden Björkhagen Kärrtorp Bagarmossen Skarpnäck'.split(' ');

trains = [];

stations = [];

segments = [];

totalDist = 0;

pause = false;

factor = 37.4;

ref = [-483, 1.778], X0 = ref[0], Y0 = ref[1];

memory = [0, 0];

getPoint = function(s) {
  var j, len, segment;
  s = modulo(s, totalDist);
  for (j = 0, len = segments.length; j < len; j++) {
    segment = segments[j];
    if (s <= segment.dist) {
      return segment.point(s);
    } else {
      s -= segment.dist;
    }
  }
};

midPoint = function(a, b) {
  return [(a[0] + b[0]) / 2, (a[1] + b[1]) / 2];
};

drawLine = function(s1, s2) {
  var ref1, ref2, x1, x2, y1, y2;
  ref1 = getPoint(s1), x1 = ref1[0], y1 = ref1[1];
  ref2 = getPoint(s2), x2 = ref2[0], y2 = ref2[1];
  return line(x1, y1, x2, y2);
};

drawLine2 = function(a, b) {
  var x1, x2, y1, y2;
  x1 = a[0], y1 = a[1];
  x2 = b[0], y2 = b[1];
  return line(x1, y1, x2, y2);
};

corr = function(a1, sp1, acc1, a2, sp2, security) {
  var d, distance;
  distance = security + sp1 * sp1 / 2 / MAX_ACC;
  d = a2 - a1;
  if (d < 0) {
    d += totalDist;
  }
  if (d <= distance) {
    return sp2 - sp1;
  } else {
    return MAX_ACC;
  }
};

Station = (function() {
  function Station(angle1, name1, duration, speed1, acc2) {
    this.angle = angle1;
    this.name = name1;
    this.duration = duration;
    this.speed = speed1 != null ? speed1 : 0;
    this.acc = acc2 != null ? acc2 : 0;
    this.angle *= totalDist;
  }

  Station.prototype.correction = function(angle, speed, acc) {
    return corr(angle, speed, acc, this.angle, this.speed, this.acc);
  };

  Station.prototype.draw = function() {
    var ref1, x, y;
    fc();
    sc(0.1);
    sw(WIDTH);
    drawLine(this.angle, this.angle - LENGTH);
    ref1 = getPoint(this.angle - 0.5 * LENGTH), x = ref1[0], y = ref1[1];
    sw(0);
    fc(0);
    textSize(5 / 3);
    textAlign(CENTER, CENTER);
    return text(this.name, x - 7.5, y);
  };

  return Station;

})();

Train = (function() {
  function Train(angle1, nextStation, nextTrain, r, g, b1, maxSpeed, maxAcc, duration) {
    this.angle = angle1;
    this.nextStation = nextStation;
    this.nextTrain = nextTrain;
    this.r = r;
    this.g = g;
    this.b = b1;
    this.maxSpeed = maxSpeed != null ? maxSpeed : MAX_SPEED;
    this.maxAcc = maxAcc != null ? maxAcc : MAX_ACC;
    this.duration = duration != null ? duration : DURATION * 1000;
    this.state = 'Run';
    this.speed = 0;
    this.acc = this.maxAcc;
    this.nextStart = millis();
    this.angle *= totalDist;
  }

  Train.prototype.correction = function(angle, speed, acc) {
    return corr(angle, speed, acc, this.angle, this.speed, LENGTH * 2);
  };

  Train.prototype.update = function(nr) {
    var ds, dt, s, t;
    this.nr = nr;
    t = this.maxSpeed / this.maxAcc;
    s = this.maxAcc * t * t / 2;
    dt = trains[this.nextTrain].angle - this.angle;
    ds = stations[this.nextStation].angle - this.angle;
    if (dt < 0) {
      dt += totalDist;
    }
    if (ds < 0) {
      ds += totalDist;
    }
    if (this.state === 'Run') {
      if (ds < 0.001) {
        this.acc = 0;
        this.speed = 0;
        this.nextStart = millis() + this.duration;
        this.state = 'Stop';
      } else {
        this.s = stations[this.nextStation].correction(this.angle, this.speed, this.acc);
        this.t = trains[this.nextTrain].correction(this.angle, this.speed, this.acc);
        this.s = constrain(this.s, -MAX_ACC, MAX_ACC);
        this.t = constrain(this.t, -MAX_ACC, MAX_ACC);
        this.acc = _.min([this.s, this.t]);
      }
    } else {
      this.acc = 0;
      if (millis() > this.nextStart) {
        this.nextStation = (this.nextStation + 1) % stations.length;
        this.state = 'Run';
        this.acc = this.maxAcc;
      }
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
    return this.angle = modulo(this.angle + this.speed * DT, totalDist);
  };

  Train.prototype.draw = function(nr) {
    var a0, a1, a2, a3, a4, a5, a6, a7, i, j, len, offset, ref1, results;
    this.update(nr);
    fc();
    sc(this.r, this.g, this.b);
    sw(WIDTH);
    ref1 = range(3);
    results = [];
    for (j = 0, len = ref1.length; j < len; j++) {
      i = ref1[j];
      offset = this.angle - i * LENGTH / 3;
      a0 = getPoint(offset - 0 * LENGTH / 9 - 1500 * MM);
      a2 = getPoint(offset - 1 * LENGTH / 9 + 150 * MM);
      a3 = getPoint(offset - 1 * LENGTH / 9 - 150 * MM);
      a4 = getPoint(offset - 2 * LENGTH / 9 + 150 * MM);
      a5 = getPoint(offset - 2 * LENGTH / 9 - 150 * MM);
      a7 = getPoint(offset - 3 * LENGTH / 9 + 1500 * MM);
      a1 = midPoint(a0, a2);
      a6 = midPoint(a5, a7);
      strokeCap(ROUND);
      drawLine2(a0, a1);
      drawLine2(a6, a7);
      strokeCap(SQUARE);
      drawLine2(a1, a2);
      drawLine2(a3, a4);
      results.push(drawLine2(a5, a6));
    }
    return results;
  };

  Train.prototype.drawText = function(nr) {
    var y;
    fc(this.r, this.g, this.b);
    y = 40 + 20 * nr;
    sc();
    textSize(16);
    textAlign(RIGHT, CENTER);
    text(this.state, 50, y);
    text(nf(FACTOR * this.acc, 0, 2), 100, y);
    text(round(FACTOR * this.speed), 150, y);
    text(round(this.angle / totalDist * MTOTAL), 200, y);
    if (this.nextStart > millis()) {
      text(round((this.nextStart - millis()) / 1000), 250, y);
    }
    textAlign(LEFT, CENTER);
    if (this.nextStation < 24) {
      return text(names[this.nextStation], 270, y);
    } else {
      return text(names[47 - this.nextStation], 270, y);
    }
  };

  return Train;

})();

ASegment = (function() {
  function ASegment(a8, b1, c, d1) {
    this.a = a8;
    this.b = b1;
    this.c = c;
    this.d = d1;
    this.dist = dist(this.a, this.b, this.c, this.d);
  }

  ASegment.prototype.point = function(d) {
    return [d / this.dist * this.c + (this.dist - d) / this.dist * this.a, d / this.dist * this.d + (this.dist - d) / this.dist * this.b];
  };

  ASegment.prototype.draw = function() {
    return line(this.a, this.b, this.c, this.d);
  };

  return ASegment;

})();

BSegment = (function() {
  function BSegment(a8, b1, c, d1, e, f, g, h, steps) {
    var i, j, len, ref1, ref2, ref3, xa, xb, ya, yb;
    this.a = a8;
    this.b = b1;
    this.c = c;
    this.d = d1;
    this.e = e;
    this.f = f;
    this.g = g;
    this.h = h;
    this.steps = steps != null ? steps : 16;
    this.dist = 0;
    ref1 = range(this.steps + 1);
    for (j = 0, len = ref1.length; j < len; j++) {
      i = ref1[j];
      ref2 = this.bp(i / this.steps), xa = ref2[0], ya = ref2[1];
      ref3 = this.bp((i + 1) / this.steps), xb = ref3[0], yb = ref3[1];
      this.dist += dist(xa, ya, xb, yb);
    }
  }

  BSegment.prototype.point = function(d) {
    return this.bp(d / this.dist);
  };

  BSegment.prototype.bp = function(t) {
    return [bezierPoint(this.a, this.c, this.e, this.g, t), bezierPoint(this.b, this.d, this.f, this.h, t)];
  };

  BSegment.prototype.draw = function() {
    return bezier(this.a, this.b, this.c, this.d, this.e, this.f, this.g, this.h);
  };

  return BSegment;

})();

setup = function() {
  var cnv, i, j, k, len, len1, name, ref1, segment, x1, x2, y0, y1, y2, y3;
  cnv = createCanvas(windowWidth, windowHeight);
  cnv.mouseWheel(changeScale);
  strokeCap(SQUARE);
  textSize(16);
  textAlign(RIGHT);
  frameRate(50);
  x1 = 485;
  x2 = 500;
  y0 = 0;
  y1 = 10;
  y2 = 790;
  y3 = 800;
  segments.push(new ASegment(x2, y1, x2, y2));
  segments.push(new BSegment(x2, y2, x2, y3, x1, y3, x1, y2));
  segments.push(new ASegment(x1, y2, x1, y1));
  segments.push(new BSegment(x1, y1, x1, y0, x2, y0, x2, y1));
  sc(1);
  sw(1);
  for (j = 0, len = segments.length; j < len; j++) {
    segment = segments[j];
    totalDist += segment.dist;
  }
  print(totalDist);
  ref1 = range(48);
  for (k = 0, len1 = ref1.length; k < len1; k++) {
    i = ref1[k];
    if (i < 24) {
      name = names[i];
    } else {
      name = '';
    }
    stations.push(new Station(0.0042 + i / 48, name, 60));
  }
  trains.push(new Train(0.000, 0, 1, 1, 0, 0));
  trains.push(new Train(0.120, 6, 2, 1, 1, 0));
  trains.push(new Train(0.246, 12, 3, 0, 1, 0));
  trains.push(new Train(0.372, 18, 4, 0, 1, 1));
  trains.push(new Train(0.498, 24, 5, 0, 0, 1));
  trains.push(new Train(0.624, 30, 6, 1, 0, 1));
  trains.push(new Train(0.750, 36, 7, 0.5, 1, 0));
  return trains.push(new Train(0.876, 42, 0, 0.75, 0.75, 0.75));
};

draw = function() {
  var i, j, k, l, len, len1, len2, len3, m, results, segment, station, train, y;
  bg(0.5);
  sc(0);
  fc(1);
  sw(0);
  y = 20;
  textSize(16);
  textAlign(RIGHT, CENTER);
  text('state', 50, y);
  text('m/s2', 100, y);
  text('m/s', 150, y);
  text('m', 200, y);
  text('s', 250, y);
  text('dest', 300, y);
  for (i = j = 0, len = trains.length; j < len; i = ++j) {
    train = trains[i];
    train.drawText(i);
  }
  scale(factor);
  translate(X0, Y0);
  for (k = 0, len1 = segments.length; k < len1; k++) {
    segment = segments[k];
    sc(1);
    sw(WIDTH);
    fc();
    segment.draw();
  }
  for (l = 0, len2 = stations.length; l < len2; l++) {
    station = stations[l];
    station.draw();
  }
  results = [];
  for (i = m = 0, len3 = trains.length; m < len3; i = ++m) {
    train = trains[i];
    results.push(train.draw(i));
  }
  return results;
};

mousePressed = function() {
  return memory = [mouseX, mouseY];
};

mouseDragged = function() {
  X0 += (mouseX - memory[0]) / factor;
  Y0 += (mouseY - memory[1]) / factor;
  return memory = [mouseX, mouseY];
};

changeScale = function(event) {
  var S;
  S = 1.1;
  X0 -= mouseX / factor;
  Y0 -= mouseY / factor;
  factor = event.deltaY > 0 ? factor / S : factor * S;
  X0 += mouseX / factor;
  return Y0 += mouseY / factor;
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsMFRBQUE7RUFBQTs7QUFBQSxNQUFBLEdBQVM7O0FBQ1QsSUFBQSxHQUFPOztBQUNQLElBQUEsR0FBTyxDQUFBLEdBQUU7O0FBQ1QsTUFBQSxHQUFTOztBQUNULE1BQUEsR0FBUyxDQUFBLEdBQUk7O0FBQ2IsUUFBQSxHQUFXOztBQUVYLE1BQUEsR0FBUzs7QUFDVCxFQUFBLEdBQUssS0FBQSxHQUFNOztBQUVYLFNBQUEsR0FBWSxNQUFBLEdBQU87O0FBQ25CLE9BQUEsR0FBWSxJQUFBLEdBQUs7O0FBQ2pCLE1BQUEsR0FBWSxJQUFBLEdBQUs7O0FBQ2pCLEtBQUEsR0FBWSxNQUFBLEdBQU87O0FBQ25CLEVBQUEsR0FBWTs7QUFFWixLQUFBLEdBQVEsa1JBQWtSLENBQUMsS0FBblIsQ0FBeVIsR0FBelI7O0FBQ1IsTUFBQSxHQUFTOztBQUNULFFBQUEsR0FBVzs7QUFDWCxRQUFBLEdBQVc7O0FBRVgsU0FBQSxHQUFZOztBQUVaLEtBQUEsR0FBUTs7QUFDUixNQUFBLEdBQVM7O0FBQ1QsTUFBUSxDQUFDLENBQUMsR0FBRixFQUFNLEtBQU4sQ0FBUixFQUFDLFdBQUQsRUFBSTs7QUFDSixNQUFBLEdBQVMsQ0FBQyxDQUFELEVBQUcsQ0FBSDs7QUFFVCxRQUFBLEdBQVcsU0FBQyxDQUFEO0FBQ1YsTUFBQTtFQUFBLFdBQUEsR0FBTTtBQUNOLE9BQUEsMENBQUE7O0lBQ0MsSUFBRyxDQUFBLElBQUssT0FBTyxDQUFDLElBQWhCO0FBQTBCLGFBQU8sT0FBTyxDQUFDLEtBQVIsQ0FBYyxDQUFkLEVBQWpDO0tBQUEsTUFBQTtNQUFzRCxDQUFBLElBQUssT0FBTyxDQUFDLEtBQW5FOztBQUREO0FBRlU7O0FBS1gsUUFBQSxHQUFXLFNBQUMsQ0FBRCxFQUFHLENBQUg7U0FBUyxDQUFDLENBQUMsQ0FB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Iiwic291cmNlc0NvbnRlbnQiOlsiTVNQRUVEID0gMjUgIyBtL3NcclxuTUFDQyA9IDEuMjUgIyBtL3MyXHJcbk1MRU4gPSAzKjQ2LjUgIyBtXHJcbk1XSURUSCA9IDMgICMgbVxyXG5NVE9UQUwgPSAyICogMTk2MDAgIyBtXHJcbkRVUkFUSU9OID0gMzAgIyBzXHJcblxyXG5GQUNUT1IgPSAyNC4zICMgbS9waXhlbCBNVE9UQUwvMTYxMS41XHJcbk1NID0gMC4wMDEvRkFDVE9SICMgcGl4ZWwvbW1cclxuXHJcbk1BWF9TUEVFRCA9IE1TUEVFRC9GQUNUT1IgIyBwaXhsYXIvc1xyXG5NQVhfQUNDICAgPSBNQUNDL0ZBQ1RPUiAjIHBpeGxhci9zMlxyXG5MRU5HVEggICAgPSBNTEVOL0ZBQ1RPUiAjIHBpeGxhclxyXG5XSURUSCAgICAgPSBNV0lEVEgvRkFDVE9SICMgMC41ICMgcGl4bGFyICMgMyw1IG9zdiBnZXIgaWNrZSBzYW1tYW5ow6RuZ2FuZGUgYmV6aWVyIG1lZCBsaW5lLiAwLjUsMiw0IG9rXHJcbkRUICAgICAgICA9IDAuMDIgIyBtc1xyXG5cclxubmFtZXMgPSAnw4VrZXNob3YgQnJvbW1hcGxhbiBBYnJhaGFtc2JlcmcgU3RvcmFNb3NzZW4gQWx2aWsgS3Jpc3RpbmViZXJnIFRob3JpbGRzcGxhbiBGcmlkaGVtc3BsYW4gUzp0RXJpa3NwbGFuIE9kZW5wbGFuIFLDpWRtYW5zZ2F0YW4gSMO2dG9yZ2V0IFQtY2VudHJhbGVuIEdhbWxhU3RhbiBTbHVzc2VuIE1lZGJvcmdhcnBsYXRzZW4gU2thbnN0dWxsIEd1bGxtYXJzcGxhbiBTa8Okcm1hcmJyaW5rIEhhbW1hcmJ5aMO2amRlbiBCasO2cmtoYWdlbiBLw6RycnRvcnAgQmFnYXJtb3NzZW4gU2thcnBuw6Rjaycuc3BsaXQgJyAnXHJcbnRyYWlucyA9IFtdXHJcbnN0YXRpb25zID0gW11cclxuc2VnbWVudHMgPSBbXVxyXG5cclxudG90YWxEaXN0ID0gMCAjIHBpeGxhclxyXG5cclxucGF1c2UgPSBmYWxzZVxyXG5mYWN0b3IgPSAzNy40XHJcbltYMCxZMF09Wy00ODMsMS43NzhdXHJcbm1lbW9yeSA9IFswLDBdXHJcblxyXG5nZXRQb2ludCA9IChzKSAtPlxyXG5cdHMgJSU9IHRvdGFsRGlzdFxyXG5cdGZvciBzZWdtZW50IGluIHNlZ21lbnRzXHJcblx0XHRpZiBzIDw9IHNlZ21lbnQuZGlzdCB0aGVuIHJldHVybiBzZWdtZW50LnBvaW50IHMgZWxzZSBzIC09IHNlZ21lbnQuZGlzdFxyXG5cclxubWlkUG9pbnQgPSAoYSxiKSAtPlx0WyhhWzBdK2JbMF0pLzIsIChhWzFdK2JbMV0pLzJdXHJcblxyXG5kcmF3TGluZSA9IChzMSxzMikgLT5cclxuXHRbeDEseTFdID0gZ2V0UG9pbnQgczFcclxuXHRbeDIseTJdID0gZ2V0UG9pbnQgczJcclxuXHRsaW5lIHgxLHkxLHgyLHkyXHJcblxyXG5kcmF3TGluZTIgPSAoYSxiKSAtPlxyXG5cdFt4MSx5MV0gPSBhXHJcblx0W3gyLHkyXSA9IGJcclxuXHRsaW5lIHgxLHkxLHgyLHkyXHJcblxyXG5jb3JyID0gKGExLHNwMSxhY2MxLGEyLHNwMixzZWN1cml0eSkgLT5cclxuXHRkaXN0YW5jZSA9IHNlY3VyaXR5ICsgc3AxKnNwMS8yL01BWF9BQ0NcclxuXHRkID0gYTItYTFcclxuXHRpZiBkIDwgMCB0aGVuIGQgKz0gdG90YWxEaXN0XHJcblx0aWYgZCA8PSBkaXN0YW5jZSB0aGVuIHNwMi1zcDEgZWxzZSBNQVhfQUNDXHJcblxyXG5jbGFzcyBTdGF0aW9uXHJcblx0Y29uc3RydWN0b3IgOiAoQGFuZ2xlLEBuYW1lLEBkdXJhdGlvbixAc3BlZWQ9MCxAYWNjPTApIC0+IEBhbmdsZSAqPSB0b3RhbERpc3RcclxuXHRjb3JyZWN0aW9uIDogKGFuZ2xlLHNwZWVkLGFjYykgLT4gY29yciBhbmdsZSxzcGVlZCxhY2MsQGFuZ2xlLEBzcGVlZCxAYWNjXHJcblx0ZHJhdyA6IC0+XHJcblx0XHRmYygpXHJcblx0XHRzYyAwLjFcclxuXHRcdHN3IFdJRFRIXHJcblx0XHRkcmF3TGluZSBAYW5nbGUsQGFuZ2xlLUxFTkdUSFxyXG5cdFx0W3gseV0gPSBnZXRQb2ludCBAYW5nbGUtMC41KkxFTkdUSFxyXG5cdFx0c3cgMFxyXG5cdFx0ZmMgMFxyXG5cdFx0dGV4dFNpemUgNS8zXHJcblx0XHR0ZXh0QWxpZ24gQ0VOVEVSLENFTlRFUlxyXG5cdFx0dGV4dCBAbmFtZSx4LTcuNSx5XHJcblxyXG5jbGFzcyBUcmFpblxyXG5cdGNvbnN0cnVjdG9yIDogKEBhbmdsZSwgQG5leHRTdGF0aW9uLCBAbmV4dFRyYWluLCBAcixAZyxAYiwgQG1heFNwZWVkPU1BWF9TUEVFRCwgQG1heEFjYz1NQVhfQUNDLCBAZHVyYXRpb249RFVSQVRJT04qMTAwMCkgLT5cclxuXHRcdEBzdGF0ZSA9ICdSdW4nICMgU3RvcCBSdW5cclxuXHRcdEBzcGVlZCA9IDBcclxuXHRcdEBhY2MgPSBAbWF4QWNjXHJcblx0XHRAbmV4dFN0YXJ0ID0gbWlsbGlzKClcclxuXHRcdEBhbmdsZSAqPSB0b3RhbERpc3RcclxuXHJcblx0Y29ycmVjdGlvbiA6IChhbmdsZSxzcGVlZCxhY2MpIC0+IGNvcnIgYW5nbGUsc3BlZWQsYWNjLEBhbmdsZSxAc3BlZWQsTEVOR1RIICogMlxyXG5cclxuXHR1cGRhdGUgOiAobnIpIC0+XHJcblxyXG5cdFx0QG5yID0gbnJcclxuXHRcdHQgPSBAbWF4U3BlZWQvQG1heEFjYyAjIDRcclxuXHRcdHMgPSBAbWF4QWNjICogdCp0IC8gMiAjIDhcclxuXHRcdGR0ID0gdHJhaW5zW0BuZXh0VHJhaW5dLmFuZ2xlIC0gQGFuZ2xlXHJcblx0XHRkcyA9IHN0YXRpb25zW0BuZXh0U3RhdGlvbl0uYW5nbGUgLSBAYW5nbGVcclxuXHJcblx0XHRpZiBkdDwwIHRoZW4gZHQgKz0gdG90YWxEaXN0XHJcblx0XHRpZiBkczwwIHRoZW4gZHMgKz0gdG90YWxEaXN0XHJcblxyXG5cdFx0aWYgQHN0YXRlPT0nUnVuJ1xyXG5cclxuXHRcdFx0aWYgZHMgPCAwLjAwMSAjcGVycm9uZ3N0b3BwIDEgbW1cclxuXHRcdFx0XHRAYWNjID0gMFxyXG5cdFx0XHRcdEBzcGVlZCA9IDBcclxuXHRcdFx0XHRAbmV4dFN0YXJ0ID0gbWlsbGlzKCkgKyBAZHVyYXRpb25cclxuXHRcdFx0XHRAc3RhdGUgPSAnU3RvcCdcclxuXHRcdFx0ZWxzZVxyXG5cdFx0XHRcdEBzID0gc3RhdGlvbnNbQG5leHRTdGF0aW9uXS5jb3JyZWN0aW9uIEBhbmdsZSxAc3BlZWQsQGFjY1xyXG5cdFx0XHRcdEB0ID0gdHJhaW5zW0BuZXh0VHJhaW5dLmNvcnJlY3Rpb24gQGFuZ2xlLEBzcGVlZCxAYWNjXHJcblx0XHRcdFx0QHMgPSBjb25zdHJhaW4gQHMsLU1BWF9BQ0MsTUFYX0FDQ1xyXG5cdFx0XHRcdEB0ID0gY29uc3RyYWluIEB0LC1NQVhfQUNDLE1BWF9BQ0NcclxuXHRcdFx0XHRAYWNjID0gXy5taW4gW0BzLEB0XVxyXG5cclxuXHRcdGVsc2VcclxuXHRcdFx0QGFjYyA9IDBcclxuXHRcdFx0aWYgbWlsbGlzKCkgPiBAbmV4dFN0YXJ0XHJcblx0XHRcdFx0QG5leHRTdGF0aW9uID0gKEBuZXh0U3RhdGlvbiArIDEpICUgc3RhdGlvbnMubGVuZ3RoXHJcblx0XHRcdFx0QHN0YXRlID0gJ1J1bidcclxuXHRcdFx0XHRAYWNjID0gQG1heEFjY1xyXG5cclxuXHRcdGlmIHBhdXNlIHRoZW4gcmV0dXJuXHJcblxyXG5cdFx0QHNwZWVkICs9IEBhY2MgKiBEVFxyXG5cdFx0aWYgQHNwZWVkID4gQG1heFNwZWVkXHJcblx0XHRcdEBhY2M9MFxyXG5cdFx0XHRAc3BlZWQgPSBAbWF4U3BlZWRcclxuXHRcdGlmIEBzcGVlZCA8IDAgdGhlbiBAc3BlZWQgPSAwXHJcblx0XHRAYW5nbGUgPSAoQGFuZ2xlICsgQHNwZWVkKkRUKSAlJSB0b3RhbERpc3RcclxuXHJcblx0ZHJhdyA6IChucikgLT5cclxuXHRcdEB1cGRhdGUgbnJcclxuXHRcdGZjKClcclxuXHRcdHNjIEByLEBnLEBiXHJcblx0XHRzdyBXSURUSFxyXG5cclxuXHRcdGZvciBpIGluIHJhbmdlIDNcclxuXHRcdFx0b2Zmc2V0ID0gQGFuZ2xlIC0gaSpMRU5HVEgvM1xyXG5cdFx0XHRhMCA9IGdldFBvaW50IG9mZnNldCAtIDAqTEVOR1RILzkgLSAxNTAwKk1NXHJcblx0XHRcdGEyID0gZ2V0UG9pbnQgb2Zmc2V0IC0gMSpMRU5HVEgvOSArIDE1MCpNTVxyXG5cdFx0XHRhMyA9IGdldFBvaW50IG9mZnNldCAtIDEqTEVOR1RILzkgLSAxNTAqTU1cclxuXHRcdFx0YTQgPSBnZXRQb2ludCBvZmZzZXQgLSAyKkxFTkdUSC85ICsgMTUwKk1NXHJcblx0XHRcdGE1ID0gZ2V0UG9pbnQgb2Zmc2V0IC0gMipMRU5HVEgvOSAtIDE1MCpNTVxyXG5cdFx0XHRhNyA9IGdldFBvaW50IG9mZnNldCAtIDMqTEVOR1RILzkgKyAxNTAwKk1NXHJcblxyXG5cdFx0XHRhMSA9IG1pZFBvaW50IGEwLGEyXHJcblx0XHRcdGE2ID0gbWlkUG9pbnQgYTUsYTdcclxuXHJcblx0XHRcdHN0cm9rZUNhcCBST1VORFxyXG5cdFx0XHRkcmF3TGluZTIgYTAsYTFcclxuXHRcdFx0ZHJhd0xpbmUyIGE2LGE3XHJcblxyXG5cdFx0XHRzdHJva2VDYXAgU1FVQVJFXHJcblx0XHRcdGRyYXdMaW5lMiBhMSxhMlxyXG5cdFx0XHRkcmF3TGluZTIgYTMsYTRcclxuXHRcdFx0ZHJhd0xpbmUyIGE1LGE2XHJcblxyXG5cdGRyYXdUZXh0IDogKG5yKSAtPlxyXG5cdFx0ZmMgQHIsQGcsQGJcclxuXHRcdHkgPSA0MCsyMCpuclxyXG5cdFx0c2MoKVxyXG5cdFx0dGV4dFNpemUgMTZcclxuXHRcdHRleHRBbGlnbiBSSUdIVCxDRU5URVJcclxuXHRcdHRleHQgQHN0YXRlLCA1MCx5XHJcblx0XHR0ZXh0IG5mKEZBQ1RPUipAYWNjLDAsMiksIDEwMCx5XHJcblx0XHR0ZXh0IHJvdW5kKEZBQ1RPUipAc3BlZWQpLCAxNTAseVxyXG5cdFx0dGV4dCByb3VuZChAYW5nbGUvdG90YWxEaXN0ICogTVRPVEFMKSwgMjAwLHlcclxuXHRcdGlmIEBuZXh0U3RhcnQgPiBtaWxsaXMoKSB0aGVuIHRleHQgcm91bmQoKEBuZXh0U3RhcnQgLSBtaWxsaXMoKSkvMTAwMCksIDI1MCx5XHJcblx0XHR0ZXh0QWxpZ24gTEVGVCxDRU5URVJcclxuXHRcdGlmIEBuZXh0U3RhdGlvbjwyNFxyXG5cdFx0XHR0ZXh0IG5hbWVzW0BuZXh0U3RhdGlvbl0sIDI3MCx5XHJcblx0XHRlbHNlXHJcblx0XHRcdHRleHQgbmFtZXNbNDctQG5leHRTdGF0aW9uXSwgMjcwLHlcclxuXHJcbmNsYXNzIEFTZWdtZW50ICMgU3RyYWlnaHRcclxuXHRjb25zdHJ1Y3RvciA6IChAYSxAYiwgQGMsQGQpIC0+IEBkaXN0ID0gZGlzdCBAYSxAYiwgQGMsQGRcclxuXHRwb2ludCA6IChkKSAtPiBbZC9AZGlzdCpAYysoQGRpc3QtZCkvQGRpc3QqQGEsIGQvQGRpc3QqQGQrKEBkaXN0LWQpL0BkaXN0KkBiXVxyXG5cdGRyYXcgOiAtPiBsaW5lIEBhLEBiLCBAYyxAZFxyXG5cclxuY2xhc3MgQlNlZ21lbnQgIyBCZXppZXJcclxuXHRjb25zdHJ1Y3RvciA6IChAYSxAYiwgQGMsQGQsIEBlLEBmLCBAZyxAaCxAc3RlcHM9MTYpIC0+XHJcblx0XHRAZGlzdCAgPSAwXHJcblx0XHRmb3IgaSBpbiByYW5nZSBAc3RlcHMrMVxyXG5cdFx0XHRbeGEseWFdID0gQGJwIGkgLyBAc3RlcHNcclxuXHRcdFx0W3hiLHliXSA9IEBicCAoaSsxKSAvIEBzdGVwc1xyXG5cdFx0XHRAZGlzdCArPSBkaXN0IHhhLHlhLCB4Yix5YlxyXG5cdHBvaW50IDogKGQpIC0+IEBicCBkL0BkaXN0XHJcblx0YnAgOiAodCkgLT4gW2JlemllclBvaW50KEBhLEBjLEBlLEBnLHQpLCBiZXppZXJQb2ludChAYixAZCxAZixAaCx0KV1cclxuXHRkcmF3IDogLT4gYmV6aWVyIEBhLEBiLCBAYyxAZCwgQGUsQGYsIEBnLEBoXHJcblxyXG5zZXR1cCA9IC0+XHJcblx0Y252ID0gY3JlYXRlQ2FudmFzIHdpbmRvd1dpZHRoLHdpbmRvd0hlaWdodFxyXG5cdGNudi5tb3VzZVdoZWVsIGNoYW5nZVNjYWxlXHJcblxyXG5cdHN0cm9rZUNhcCBTUVVBUkVcclxuXHJcblx0dGV4dFNpemUgMTZcclxuXHR0ZXh0QWxpZ24gUklHSFRcclxuXHRmcmFtZVJhdGUgNTBcclxuXHJcblx0eDEgPSA0ODVcclxuXHR4MiA9IDUwMFxyXG5cdHkwID0gMFxyXG5cdHkxID0gMTBcclxuXHR5MiA9IDc5MFxyXG5cdHkzID0gODAwXHJcblx0c2VnbWVudHMucHVzaCBuZXcgQVNlZ21lbnQgeDIseTEsIHgyLHkyXHJcblx0c2VnbWVudHMucHVzaCBuZXcgQlNlZ21lbnQgeDIseTIsIHgyLHkzLCB4MSx5MywgeDEseTJcclxuXHRzZWdtZW50cy5wdXNoIG5ldyBBU2VnbWVudCB4MSx5MiwgeDEseTFcclxuXHRzZWdtZW50cy5wdXNoIG5ldyBCU2VnbWVudCB4MSx5MSwgeDEseTAsIHgyLHkwLCB4Mix5MVxyXG5cclxuXHRzYyAxXHJcblx0c3cgMVxyXG5cclxuXHRmb3Igc2VnbWVudCBpbiBzZWdtZW50c1xyXG5cdFx0dG90YWxEaXN0ICs9IHNlZ21lbnQuZGlzdFxyXG5cdHByaW50IHRvdGFsRGlzdFxyXG5cclxuXHRmb3IgaSBpbiByYW5nZSA0OFxyXG5cdFx0aWYgaTwyNCB0aGVuIG5hbWUgPSBuYW1lc1tpXSBlbHNlIG5hbWUgPSAnJ1xyXG5cdFx0c3RhdGlvbnMucHVzaCBuZXcgU3RhdGlvbiAwLjAwNDIgKyBpLzQ4LG5hbWUsNjBcclxuXHJcblx0dHJhaW5zLnB1c2ggbmV3IFRyYWluIDAuMDAwLCAgMCwxLCAxLDAsMFxyXG5cdHRyYWlucy5wdXNoIG5ldyBUcmFpbiAwLjEyMCwgIDYsMiwgMSwxLDBcclxuXHR0cmFpbnMucHVzaCBuZXcgVHJhaW4gMC4yNDYsIDEyLDMsIDAsMSwwXHJcblx0dHJhaW5zLnB1c2ggbmV3IFRyYWluIDAuMzcyLCAxOCw0LCAwLDEsMVxyXG5cdHRyYWlucy5wdXNoIG5ldyBUcmFpbiAwLjQ5OCwgMjQsNSwgMCwwLDFcclxuXHR0cmFpbnMucHVzaCBuZXcgVHJhaW4gMC42MjQsIDMwLDYsIDEsMCwxXHJcblx0dHJhaW5zLnB1c2ggbmV3IFRyYWluIDAuNzUwLCAzNiw3LCAwLjUsMSwwXHJcblx0dHJhaW5zLnB1c2ggbmV3IFRyYWluIDAuODc2LCA0MiwwLCAwLjc1LDAuNzUsMC43NVxyXG5cclxuZHJhdyA9IC0+XHJcblx0YmcgMC41XHJcblxyXG5cdHNjIDBcclxuXHRmYyAxXHJcblx0c3cgMFxyXG5cdHkgPSAyMFxyXG5cdHRleHRTaXplIDE2XHJcblx0dGV4dEFsaWduIFJJR0hULENFTlRFUlxyXG5cdHRleHQgJ3N0YXRlJywgNTAseVxyXG5cdHRleHQgJ20vczInLCAxMDAseVxyXG5cdHRleHQgJ20vcycsICAxNTAseVxyXG5cdHRleHQgJ20nLCAgICAyMDAseVxyXG5cdHRleHQgJ3MnLCAgICAyNTAseVxyXG5cdHRleHQgJ2Rlc3QnLCAzMDAseVxyXG5cdHRyYWluLmRyYXdUZXh0IGkgZm9yIHRyYWluLGkgaW4gdHJhaW5zXHJcblxyXG5cdHNjYWxlIGZhY3RvclxyXG5cdHRyYW5zbGF0ZSBYMCxZMFxyXG5cclxuXHRmb3Igc2VnbWVudCBpbiBzZWdtZW50c1xyXG5cdFx0c2MgMVxyXG5cdFx0c3cgV0lEVEhcclxuXHRcdGZjKClcclxuXHRcdHNlZ21lbnQuZHJhdygpXHJcblxyXG5cdHN0YXRpb24uZHJhdygpIGZvciBzdGF0aW9uIGluIHN0YXRpb25zXHJcblx0dHJhaW4uZHJhdyBpIGZvciB0cmFpbixpIGluIHRyYWluc1xyXG5cclxubW91c2VQcmVzc2VkID0gLT4gbWVtb3J5ID0gW21vdXNlWCxtb3VzZVldXHJcbm1vdXNlRHJhZ2dlZCA9IC0+XHJcblx0WDAgKz0gKG1vdXNlWCAtIG1lbW9yeVswXSkgLyBmYWN0b3JcclxuXHRZMCArPSAobW91c2VZIC0gbWVtb3J5WzFdKSAvIGZhY3RvclxyXG5cdG1lbW9yeSA9IFttb3VzZVgsbW91c2VZXVxyXG5cclxuY2hhbmdlU2NhbGUgPSAoZXZlbnQpIC0+XHJcblx0UyA9IDEuMVxyXG5cdFgwIC09IG1vdXNlWCAvIGZhY3RvclxyXG5cdFkwIC09IG1vdXNlWSAvIGZhY3RvclxyXG5cdGZhY3RvciA9IGlmIGV2ZW50LmRlbHRhWSA+IDAgdGhlbiBmYWN0b3IvUyBlbHNlIGZhY3RvcipTXHJcblx0WDAgKz0gbW91c2VYIC8gZmFjdG9yXHJcblx0WTAgKz0gbW91c2VZIC8gZmFjdG9yXHJcbiJdfQ==
//# sourceURL=C:\Lab\2017\075-simulator-Linje17\coffee\sketch.coffee