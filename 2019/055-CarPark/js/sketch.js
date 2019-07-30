// Generated by CoffeeScript 2.3.2
var Car, Point, SIZE, bestScore, cars, distance, draw, init, intersecting, lastX, lastY, mousePressed, score, setup, start;

SIZE = 2;

cars = [];

start = new Date();

bestScore = 999999999;

lastX = null;

lastY = null;

Point = class Point {
  constructor(x1, y1) {
    this.x = x1;
    this.y = y1;
  }

};

Car = class Car {
  
  // @active 
  //   0 = passive car
  //   1 = moving car 
  //   2 = target parking spot
  // @x,@y anger bakaxelns mittpunkt
  constructor(x1, y1, length, width, active = 0, direction = 0, speed = 0, steering = 0) {
    this.makePolygon = this.makePolygon.bind(this);
    this.transform = this.transform.bind(this);
    this.x = x1;
    this.y = y1;
    this.length = length;
    this.width = width;
    this.active = active;
    this.direction = direction;
    this.speed = speed;
    this.steering = steering;
    this.makePolygon();
  }

  clone() {
    return JSON.parse(JSON.stringify(this));
  }

  makePolygon() {
    var a1, a2, d1, d2;
    a1 = atan2(-1, -1); // degrees 
    a2 = atan2(-1, 4); // degrees
    d1 = SIZE * sqrt(20 * 20 + 20 * 20);
    d2 = SIZE * sqrt(80 * 80 + 20 * 20);
    this.polygon = [];
    this.polygon.push(this.transform(d1, a1));
    this.polygon.push(this.transform(d2, a2));
    this.polygon.push(this.transform(d2, -a2));
    return this.polygon.push(this.transform(d1, -a1));
  }

  transform(d, a) {
    return new Point(this.x + d * cos(this.direction + a), this.y + d * sin(this.direction + a));
  }

  draw() {
    if (this.active === 2) {
      return;
    }
    push();
    translate(this.x, this.y);
    rotate(this.direction);
    fc(1);
    if (this.active === 1) {
      fc(1, 1, 0);
    }
    rectMode(CORNER);
    rect(-0.2 * this.length, -0.5 * this.width, this.length, this.width);
    sw(5);
    sc(0);
    point(0, 0);
    sw(1);
    this.x0 = 0; // bakaxel
    this.x1 = 0 + 0.60 * this.length; // framaxel
    this.y0 = 0 - 0.4 * this.width;
    this.y1 = 0 + 0.4 * this.width;
    line(this.x0, this.y0, this.x0, this.y1);
    line(this.x1, this.y0, this.x1, this.y1);
    fc(0);
    rectMode(CENTER);
    // rita bakhjul
    rect(this.x0, this.y0, 0.2 * this.length, 0.2 * this.width);
    rect(this.x0, this.y1, 0.2 * this.length, 0.2 * this.width);
    // rita VF
    push();
    translate(this.x1, this.y0);
    rotate(5 * this.steering);
    rect(0, 0, 0.2 * this.length, 0.2 * this.width);
    pop();
    // rita HF
    push();
    translate(this.x1, this.y1);
    rotate(5 * this.steering);
    rect(0, 0, 0.2 * this.length, 0.2 * this.width);
    pop();
    return pop();
  }

  update() {
    if (this.active !== 1) {
      return;
    }
    if (lastX === null || lastX === (void 0)) {
      return;
    }
    if (lastY === null || lastY === (void 0)) {
      return;
    }
    // gs = navigator.getGamepads()
    // if gs and gs[0] then @speed = -2 * gs[0].axes[1] 
    // if gs and gs[0] then @steering = 10 * gs[0].axes[0] 
    // @steering = constrain @steering,-30,30
    this.steering += (mouseX - lastX) / 50;
    this.speed += (lastY - mouseY) / 50;
    lastX = mouseX;
    lastY = mouseY;
    this.steering = constrain(this.steering, -10, 10);
    this.speed = constrain(this.speed, -10, 10);
    this.x += this.speed * cos(this.direction);
    this.y += this.speed * sin(this.direction);
    this.direction += this.speed / 10 * this.steering;
    this.makePolygon();
    return this.checkCollision();
  }

  checkCollision() {
    var car, k, len, results;
    results = [];
    for (k = 0, len = cars.length; k < len; k++) {
      car = cars[k];
      if (car.active === 0) {
        if (intersecting(this.polygon, car.polygon)) {
          results.push(this.active = 0);
        } else {
          results.push(void 0);
        }
      } else {
        results.push(void 0);
      }
    }
    return results;
  }

};

setup = function() {
  //gs = navigator.getGamepads()
  createCanvas(SIZE * 800, 1000);
  angleMode(DEGREES);
  return textSize(100);
};

init = function() {
  var i, j, k, l, len, len1, ref, ref1, x, y;
  cars = [];
  start = new Date();
  bestScore = 999999999;
  lastX = mouseX;
  lastY = mouseY;
  ref = range(5);
  for (k = 0, len = ref.length; k < len; k++) {
    i = ref[k];
    ref1 = range(2);
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      j = ref1[l];
      x = 400 + i * 50 * SIZE;
      y = 100 + j * 300 * SIZE;
      cars.push(new Car(x, y, SIZE * 100, SIZE * 40, 0, j === 0 ? 90 : 270));
    }
  }
  cars[7].active = 2; // target parking lot
  return cars.push(new Car(SIZE * 100, SIZE * 200, SIZE * 100, SIZE * 40, 1));
};

// car = new Car 100,100,100,40,false,0
// assert car.polygon, [new Point(80,80),new Point(180,80),new Point(180,120),new Point(80,120)]
// car.direction = 90
// car.makePolygon()
// assert car.polygon, [new Point(120,80),new Point(120.00000000000001,180),new Point(80,180), new Point(80,80)]
// car.direction = 45
// car.makePolygon()
// assert car.polygon, [new Point(100, 71.7157287525381), new Point(170.71067811865476, 142.42640687119285), new Point(142.42640687119285, 170.71067811865476), new Point(71.7157287525381, 100)]
// console.log 'ready'
mousePressed = function() {
  return init();
};

draw = function() {
  var car, k, len, stopp, temp;
  if (cars.length === 0) {
    return;
  }
  bg(0.5);
  for (k = 0, len = cars.length; k < len; k++) {
    car = cars[k];
    car.draw();
  }
  cars[10].update();
  stopp = new Date();
  temp = score(cars[10], cars[7]) + (stopp - start) / 1000;
  if (temp < bestScore) {
    bestScore = temp;
  }
  return text(round(bestScore), 100, 100);
};

score = function(a, b) {
  var i, k, len, ref, result;
  result = 0;
  ref = range(4);
  for (k = 0, len = ref.length; k < len; k++) {
    i = ref[k];
    result += distance(a.polygon[i], b.polygon[i]);
  }
  return result;
};

distance = function(p1, p2) {
  return dist(p1.x, p1.y, p2.x, p2.y);
};

// Checks if two polygons are intersecting.
intersecting = (a, b) => { // polygons
  var i1, i2, k, l, len, len1, len2, len3, m, maxA, maxB, minA, minB, n, normal, p, p1, p2, polygon, projected, ref, ref1;
  ref = [a, b];
  for (k = 0, len = ref.length; k < len; k++) {
    polygon = ref[k];
    ref1 = range(polygon.length);
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      i1 = ref1[l];
      i2 = (i1 + 1) % polygon.length;
      p1 = polygon[i1];
      p2 = polygon[i2];
      normal = new Point(p2.y - p1.y, p1.x - p2.x);
      minA = null;
      maxA = null;
      for (m = 0, len2 = a.length; m < len2; m++) {
        p = a[m];
        projected = normal.x * p.x + normal.y * p.y;
        if (minA === null || projected < minA) {
          minA = projected;
        }
        if (maxA === null || projected > maxA) {
          maxA = projected;
        }
      }
      minB = null;
      maxB = null;
      for (n = 0, len3 = b.length; n < len3; n++) {
        p = b[n];
        projected = normal.x * p.x + normal.y * p.y;
        if (minB === null || projected < minB) {
          minB = projected;
        }
        if (maxB === null || projected > maxB) {
          maxB = projected;
        }
      }
      if (maxA < minB || maxB < minA) {
        return false;
      }
    }
  }
  return true;
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsR0FBQSxFQUFBLEtBQUEsRUFBQSxJQUFBLEVBQUEsU0FBQSxFQUFBLElBQUEsRUFBQSxRQUFBLEVBQUEsSUFBQSxFQUFBLElBQUEsRUFBQSxZQUFBLEVBQUEsS0FBQSxFQUFBLEtBQUEsRUFBQSxZQUFBLEVBQUEsS0FBQSxFQUFBLEtBQUEsRUFBQTs7QUFBQSxJQUFBLEdBQU87O0FBRVAsSUFBQSxHQUFPOztBQUNQLEtBQUEsR0FBUSxJQUFJLElBQUosQ0FBQTs7QUFDUixTQUFBLEdBQVk7O0FBQ1osS0FBQSxHQUFROztBQUNSLEtBQUEsR0FBUTs7QUFFRixRQUFOLE1BQUEsTUFBQTtFQUNDLFdBQWMsR0FBQSxJQUFBLENBQUE7SUFBQyxJQUFDLENBQUE7SUFBRSxJQUFDLENBQUE7RUFBTDs7QUFEZjs7QUFHTSxNQUFOLE1BQUEsSUFBQSxDQUFBOzs7Ozs7O0VBTUMsV0FBYyxHQUFBLElBQUEsUUFBQSxPQUFBLFdBQStCLENBQS9CLGNBQTZDLENBQTdDLFVBQXVELENBQXZELGFBQW9FLENBQXBFLENBQUE7UUFLZCxDQUFBLGtCQUFBLENBQUE7UUFXQSxDQUFBLGdCQUFBLENBQUE7SUFoQmUsSUFBQyxDQUFBO0lBQUUsSUFBQyxDQUFBO0lBQUUsSUFBQyxDQUFBO0lBQU8sSUFBQyxDQUFBO0lBQU8sSUFBQyxDQUFBO0lBQVUsSUFBQyxDQUFBO0lBQWEsSUFBQyxDQUFBO0lBQVMsSUFBQyxDQUFBO0lBQ3hFLElBQUMsQ0FBQSxXQUFELENBQUE7RUFEYTs7RUFHZCxLQUFRLENBQUEsQ0FBQTtXQUFHLElBQUksQ0FBQyxLQUFMLENBQVcsSUFBSSxDQUFDLFNBQUwsQ0FBZSxJQUFmLENBQVg7RUFBSDs7RUFFUixXQUFjLENBQUEsQ0FBQTtBQUNiLFFBQUEsRUFBQSxFQUFBLEVBQUEsRUFBQSxF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QVEsSUFBUixJQUFnQixTQUFBLEdBQVksSUFBL0I7VUFBeUMsSUFBQSxHQUFPLFVBQWhEOztNQUhEO01BS0EsSUFBRyxJQUFBLEdBQU8sSUFBUCxJQUFlLElBQUEsR0FBTyxJQUF6QjtBQUFtQyxlQUFPLE1BQTFDOztJQXJCRDtFQUREO1NBdUJBO0FBeEJjIiwic291cmNlc0NvbnRlbnQiOlsiU0laRSA9IDJcclxuXHJcbmNhcnMgPSBbXVxyXG5zdGFydCA9IG5ldyBEYXRlKClcclxuYmVzdFNjb3JlID0gOTk5OTk5OTk5XHJcbmxhc3RYID0gbnVsbFxyXG5sYXN0WSA9IG51bGxcclxuXHJcbmNsYXNzIFBvaW50IFxyXG5cdGNvbnN0cnVjdG9yIDogKEB4LEB5KSAtPlxyXG5cclxuY2xhc3MgQ2FyIFxyXG5cdCMgQGFjdGl2ZSBcclxuXHQjICAgMCA9IHBhc3NpdmUgY2FyXHJcblx0IyAgIDEgPSBtb3ZpbmcgY2FyIFxyXG5cdCMgICAyID0gdGFyZ2V0IHBhcmtpbmcgc3BvdFxyXG5cdCMgQHgsQHkgYW5nZXIgYmFrYXhlbG5zIG1pdHRwdW5rdFxyXG5cdGNvbnN0cnVjdG9yIDogKEB4LEB5LEBsZW5ndGgsQHdpZHRoLCBAYWN0aXZlPTAsIEBkaXJlY3Rpb249MCwgQHNwZWVkPTAsIEBzdGVlcmluZz0wKSAtPlxyXG5cdFx0QG1ha2VQb2x5Z29uKClcclxuXHJcblx0Y2xvbmUgOiAtPiBKU09OLnBhcnNlIEpTT04uc3RyaW5naWZ5IEBcclxuXHJcblx0bWFrZVBvbHlnb24gOiAoKSA9PlxyXG5cdFx0YTEgPSBhdGFuMiAtMSwtMSAgICMgZGVncmVlcyBcclxuXHRcdGEyID0gYXRhbjIgLTEsNCAgICAjIGRlZ3JlZXNcclxuXHRcdGQxID0gU0laRSAqIHNxcnQgMjAqMjArMjAqMjBcclxuXHRcdGQyID0gU0laRSAqIHNxcnQgODAqODArMjAqMjBcclxuXHRcdEBwb2x5Z29uID0gW11cclxuXHRcdEBwb2x5Z29uLnB1c2ggQHRyYW5zZm9ybSBkMSxhMSAgXHJcblx0XHRAcG9seWdvbi5wdXNoIEB0cmFuc2Zvcm0gZDIsYTIgXHJcblx0XHRAcG9seWdvbi5wdXNoIEB0cmFuc2Zvcm0gZDIsLWEyXHJcblx0XHRAcG9seWdvbi5wdXNoIEB0cmFuc2Zvcm0gZDEsLWExIFxyXG5cclxuXHR0cmFuc2Zvcm0gOiAoZCxhKSA9PiBuZXcgUG9pbnQgQHggKyBkKmNvcyhAZGlyZWN0aW9uK2EpLCAgQHkrZCpzaW4oQGRpcmVjdGlvbithKVxyXG5cclxuXHRkcmF3IDogLT5cclxuXHRcdGlmIEBhY3RpdmUgPT0gMiB0aGVuIHJldHVybiAgXHJcblx0XHRwdXNoKClcclxuXHRcdHRyYW5zbGF0ZSBAeCxAeVxyXG5cdFx0cm90YXRlIEBkaXJlY3Rpb25cclxuXHJcblx0XHRmYyAxXHJcblx0XHRpZiBAYWN0aXZlID09IDEgdGhlbiBmYyAxLDEsMFxyXG5cclxuXHRcdHJlY3RNb2RlIENPUk5FUlxyXG5cdFx0cmVjdCAtMC4yKkBsZW5ndGgsLTAuNSpAd2lkdGgsQGxlbmd0aCxAd2lkdGhcclxuXHJcblx0XHRzdyA1XHJcblx0XHRzYyAwXHJcblx0XHRwb2ludCAwLDBcclxuXHRcdHN3IDFcclxuXHJcblx0XHRAeDAgPSAwICAgICAgICAgICAgICAgICAgIyBiYWtheGVsXHJcblx0XHRAeDEgPSAwICsgMC42MCAqIEBsZW5ndGggIyBmcmFtYXhlbFxyXG5cdFx0QHkwID0gMCAtIDAuNCAqIEB3aWR0aFxyXG5cdFx0QHkxID0gMCArIDAuNCAqIEB3aWR0aFxyXG5cclxuXHRcdGxpbmUgQHgwLEB5MCxAeDAsQHkxIFxyXG5cdFx0bGluZSBAeDEsQHkwLEB4MSxAeTEgXHJcblx0XHRmYyAwXHJcblx0XHRyZWN0TW9kZSBDRU5URVJcclxuXHJcblx0XHQjIHJpdGEgYmFraGp1bFxyXG5cdFx0cmVjdCBAeDAsQHkwLDAuMipAbGVuZ3RoLDAuMipAd2lkdGhcclxuXHRcdHJlY3QgQHgwLEB5MSwwLjIqQGxlbmd0aCwwLjIqQHdpZHRoXHJcblxyXG5cdFx0IyByaXRhIFZGXHJcblx0XHRwdXNoKClcclxuXHRcdHRyYW5zbGF0ZSBAeDEsQHkwXHJcblx0XHRyb3RhdGUgNSpAc3RlZXJpbmdcclxuXHRcdHJlY3QgMCwwLDAuMipAbGVuZ3RoLDAuMipAd2lkdGhcclxuXHRcdHBvcCgpXHJcblxyXG5cdFx0IyByaXRhIEhGXHJcblx0XHRwdXNoKClcclxuXHRcdHRyYW5zbGF0ZSBAeDEsQHkxXHJcblx0XHRyb3RhdGUgNSpAc3RlZXJpbmdcclxuXHRcdHJlY3QgMCwwLDAuMipAbGVuZ3RoLDAuMipAd2lkdGhcclxuXHRcdHBvcCgpXHJcblxyXG5cdFx0cG9wKClcclxuXHJcblx0dXBkYXRlIDogLT5cclxuXHRcdGlmIEBhY3RpdmUgIT0gMSB0aGVuIHJldHVyblxyXG5cdFx0aWYgbGFzdFggaW4gW251bGwsdW5kZWZpbmVkXSB0aGVuIHJldHVyblxyXG5cdFx0aWYgbGFzdFkgaW4gW251bGwsdW5kZWZpbmVkXSB0aGVuIHJldHVyblxyXG5cclxuXHRcdCMgZ3MgPSBuYXZpZ2F0b3IuZ2V0R2FtZXBhZHMoKVxyXG5cdFx0IyBpZiBncyBhbmQgZ3NbMF0gdGhlbiBAc3BlZWQgPSAtMiAqIGdzWzBdLmF4ZXNbMV0gXHJcblx0XHQjIGlmIGdzIGFuZCBnc1swXSB0aGVuIEBzdGVlcmluZyA9IDEwICogZ3NbMF0uYXhlc1swXSBcclxuXHRcdCMgQHN0ZWVyaW5nID0gY29uc3RyYWluIEBzdGVlcmluZywtMzAsMzBcclxuXHJcblx0XHRAc3RlZXJpbmcgKz0gKG1vdXNlWC1sYXN0WCkvNTBcclxuXHRcdEBzcGVlZCArPSAobGFzdFktbW91c2VZKS81MFxyXG5cdFx0bGFzdFggPSBtb3VzZVhcclxuXHRcdGxhc3RZID0gbW91c2VZXHJcblxyXG5cdFx0QHN0ZWVyaW5nID0gY29uc3RyYWluIEBzdGVlcmluZywtMTAsMTBcclxuXHRcdEBzcGVlZCA9IGNvbnN0cmFpbiBAc3BlZWQsLTEwLDEwXHJcblxyXG5cdFx0QHggKz0gQHNwZWVkICogY29zIEBkaXJlY3Rpb25cclxuXHRcdEB5ICs9IEBzcGVlZCAqIHNpbiBAZGlyZWN0aW9uXHJcblx0XHRAZGlyZWN0aW9uICs9IEBzcGVlZC8xMCAqIEBzdGVlcmluZ1xyXG5cdFx0QG1ha2VQb2x5Z29uKClcclxuXHRcdEBjaGVja0NvbGxpc2lvbigpXHJcblxyXG5cdGNoZWNrQ29sbGlzaW9uIDogKCkgLT5cclxuXHRcdGZvciBjYXIgaW4gY2Fyc1xyXG5cdFx0XHRpZiBjYXIuYWN0aXZlID09IDBcclxuXHRcdFx0XHRpZiBpbnRlcnNlY3RpbmcgQHBvbHlnb24sIGNhci5wb2x5Z29uIFxyXG5cdFx0XHRcdFx0QGFjdGl2ZSA9IDBcclxuXHJcblxyXG5zZXR1cCA9IC0+XHJcblx0I2dzID0gbmF2aWdhdG9yLmdldEdhbWVwYWRzKClcclxuXHRjcmVhdGVDYW52YXMgU0laRSo4MDAsMTAwMFxyXG5cdGFuZ2xlTW9kZSBERUdSRUVTXHJcblx0dGV4dFNpemUgMTAwXHJcblxyXG5pbml0ID0gLT5cclxuXHRjYXJzID0gW11cclxuXHRzdGFydCA9IG5ldyBEYXRlKClcclxuXHRiZXN0U2NvcmUgPSA5OTk5OTk5OTlcclxuXHRsYXN0WCA9IG1vdXNlWFxyXG5cdGxhc3RZID0gbW91c2VZXHJcblx0Zm9yIGkgaW4gcmFuZ2UgNVxyXG5cdFx0Zm9yIGogaW4gcmFuZ2UgMlxyXG5cdFx0XHR4ID0gNDAwK2kqNTAqU0laRVxyXG5cdFx0XHR5ID0gMTAwK2oqMzAwKlNJWkVcclxuXHRcdFx0Y2Fycy5wdXNoIG5ldyBDYXIgeCx5LFNJWkUqMTAwLFNJWkUqNDAsMCxpZiBqPT0wIHRoZW4gOTAgZWxzZSAyNzBcclxuXHRjYXJzWzddLmFjdGl2ZSA9IDIgIyB0YXJnZXQgcGFya2luZyBsb3RcclxuXHRjYXJzLnB1c2ggbmV3IENhciBTSVpFKjEwMCxTSVpFKjIwMCxTSVpFKjEwMCxTSVpFKjQwLDFcclxuXHJcblx0IyBjYXIgPSBuZXcgQ2FyIDEwMCwxMDAsMTAwLDQwLGZhbHNlLDBcclxuXHQjIGFzc2VydCBjYXIucG9seWdvbiwgW25ldyBQb2ludCg4MCw4MCksbmV3IFBvaW50KDE4MCw4MCksbmV3IFBvaW50KDE4MCwxMjApLG5ldyBQb2ludCg4MCwxMjApXVxyXG5cdCMgY2FyLmRpcmVjdGlvbiA9IDkwXHJcblx0IyBjYXIubWFrZVBvbHlnb24oKVxyXG5cdCMgYXNzZXJ0IGNhci5wb2x5Z29uLCBbbmV3IFBvaW50KDEyMCw4MCksbmV3IFBvaW50KDEyMC4wMDAwMDAwMDAwMDAwMSwxODApLG5ldyBQb2ludCg4MCwxODApLCBuZXcgUG9pbnQoODAsODApXVxyXG5cdCMgY2FyLmRpcmVjdGlvbiA9IDQ1XHJcblx0IyBjYXIubWFrZVBvbHlnb24oKVxyXG5cdCMgYXNzZXJ0IGNhci5wb2x5Z29uLCBbbmV3IFBvaW50KDEwMCwgNzEuNzE1NzI4NzUyNTM4MSksIG5ldyBQb2ludCgxNzAuNzEwNjc4MTE4NjU0NzYsIDE0Mi40MjY0MDY4NzExOTI4NSksIG5ldyBQb2ludCgxNDIuNDI2NDA2ODcxMTkyODUsIDE3MC43MTA2NzgxMTg2NTQ3NiksIG5ldyBQb2ludCg3MS43MTU3Mjg3NTI1MzgxLCAxMDApXVxyXG5cdCMgY29uc29sZS5sb2cgJ3JlYWR5J1xyXG5cclxubW91c2VQcmVzc2VkID0gLT4gaW5pdCgpXHJcblxyXG5kcmF3ID0gLT5cclxuXHRpZiBjYXJzLmxlbmd0aCA9PSAwIHRoZW4gcmV0dXJuIFxyXG5cdGJnIDAuNVxyXG5cdGZvciBjYXIgaW4gY2Fyc1xyXG5cdFx0Y2FyLmRyYXcoKVxyXG5cdGNhcnNbMTBdLnVwZGF0ZSgpXHJcblx0c3RvcHAgPSBuZXcgRGF0ZSgpXHJcblx0dGVtcCA9IHNjb3JlKGNhcnNbMTBdLCBjYXJzWzddKSArIChzdG9wcCAtIHN0YXJ0KS8xMDAwXHJcblx0aWYgdGVtcCA8IGJlc3RTY29yZSB0aGVuIGJlc3RTY29yZSA9IHRlbXBcclxuXHR0ZXh0IHJvdW5kKGJlc3RTY29yZSksMTAwLDEwMFxyXG5cclxuc2NvcmUgPSAoYSxiKSAtPlxyXG5cdHJlc3VsdCA9IDBcclxuXHRmb3IgaSBpbiByYW5nZSA0XHJcblx0XHRyZXN1bHQgKz0gZGlzdGFuY2UgYS5wb2x5Z29uW2ldLCBiLnBvbHlnb25baV1cclxuXHRyZXN1bHRcclxuXHJcbmRpc3RhbmNlID0gKHAxLHAyKSAtPiBkaXN0IHAxLngscDEueSxwMi54LHAyLnlcclxuXHJcbiMgQ2hlY2tzIGlmIHR3byBwb2x5Z29ucyBhcmUgaW50ZXJzZWN0aW5nLlxyXG5pbnRlcnNlY3RpbmcgPSAoYSwgYikgPT4gIyBwb2x5Z29uc1xyXG5cdGZvciBwb2x5Z29uIGluIFthLGJdXHJcblx0XHRmb3IgaTEgaW4gcmFuZ2UgcG9seWdvbi5sZW5ndGhcclxuXHRcdFx0aTIgPSAoaTEgKyAxKSAlIHBvbHlnb24ubGVuZ3RoXHJcblx0XHRcdHAxID0gcG9seWdvbltpMV1cclxuXHRcdFx0cDIgPSBwb2x5Z29uW2kyXVxyXG5cclxuXHRcdFx0bm9ybWFsID0gbmV3IFBvaW50IHAyLnkgLSBwMS55LCBwMS54IC0gcDIueFxyXG5cclxuXHRcdFx0bWluQSA9IG51bGxcclxuXHRcdFx0bWF4QSA9IG51bGxcclxuXHRcdFx0Zm9yIHAgaW4gYVxyXG5cdFx0XHRcdHByb2plY3RlZCA9IG5vcm1hbC54ICogcC54ICsgbm9ybWFsLnkgKiBwLnlcclxuXHRcdFx0XHRpZiBtaW5BID09IG51bGwgb3IgcHJvamVjdGVkIDwgbWluQSB0aGVuIG1pbkEgPSBwcm9qZWN0ZWRcclxuXHRcdFx0XHRpZiBtYXhBID09IG51bGwgb3IgcHJvamVjdGVkID4gbWF4QSB0aGVuIG1heEEgPSBwcm9qZWN0ZWRcclxuXHJcblx0XHRcdG1pbkIgPSBudWxsXHJcblx0XHRcdG1heEIgPSBudWxsXHJcblx0XHRcdGZvciBwIGluIGJcclxuXHRcdFx0XHRwcm9qZWN0ZWQgPSBub3JtYWwueCAqIHAueCArIG5vcm1hbC55ICogcC55XHJcblx0XHRcdFx0aWYgbWluQiA9PSBudWxsIG9yIHByb2plY3RlZCA8IG1pbkIgdGhlbiBtaW5CID0gcHJvamVjdGVkXHJcblx0XHRcdFx0aWYgbWF4QiA9PSBudWxsIG9yIHByb2plY3RlZCA+IG1heEIgdGhlbiBtYXhCID0gcHJvamVjdGVkXHJcblxyXG5cdFx0XHRpZiBtYXhBIDwgbWluQiBvciBtYXhCIDwgbWluQSB0aGVuIHJldHVybiBmYWxzZVxyXG5cdHRydWVcclxuIl19
//# sourceURL=c:\Lab\2019\055-CarPark\coffee\sketch.coffee