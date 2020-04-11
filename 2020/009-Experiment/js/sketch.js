// Generated by CoffeeScript 2.4.1
var Ball, active, balls, createBall, draw, level, mousePressed, reset, setup, start, stopp;

level = 0;

active = 0;

start = null;

stopp = null;

Ball = class Ball {
  constructor(radie1, x1, y1, dx1, dy1, r1, g1, b1) {
    this.radie = radie1;
    this.x = x1;
    this.y = y1;
    this.dx = dx1;
    this.dy = dy1;
    this.r = r1;
    this.g = g1;
    this.b = b1;
    this.active = true;
  }

  rita() {
    if (!this.active) {
      return;
    }
    if (this.x > width - this.radie) {
      this.dx = -this.dx;
    }
    if (this.x < this.radie) {
      this.dx = -this.dx;
    }
    this.x += this.dx;
    if (this.y > height - this.radie) {
      this.dy = -this.dy;
    } else {
      this.dy += 0.1;
    }
    this.y += this.dy;
    fc(this.r, this.g, this.b);
    return circle(this.x, this.y, this.radie);
  }

  inside(mx, my) {
    return dist(this.x, this.y, mx, my) < this.radie;
  }

};

balls = [];

reset = function() {
  var i, j, len, ref, results;
  start = new Date();
  level++;
  balls = [];
  ref = range(level);
  results = [];
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    results.push(createBall());
  }
  return results;
};

setup = function() {
  createCanvas(800, 600);
  reset();
  textSize(100);
  return textAlign(CENTER, CENTER);
};

draw = function() {
  var ball, j, len;
  bg(0);
  for (j = 0, len = balls.length; j < len; j++) {
    ball = balls[j];
    ball.rita();
  }
  if (active === 0) {
    fc(1);
    return text((stopp - start) / 1000, width / 2, height / 2);
  }
};

mousePressed = function() {
  var ball, j, len, results;
  if (active === 0) {
    return reset();
  } else {
    results = [];
    for (j = 0, len = balls.length; j < len; j++) {
      ball = balls[j];
      if (ball.inside(mouseX, mouseY)) {
        ball.active = false;
        active--;
        if (active === 0) {
          results.push(stopp = new Date());
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

createBall = function() {
  var b, dx, dy, g, r, radie, x, y;
  active++;
  x = random(50, width);
  y = random(50, 100);
  dx = random(-2, 2);
  dy = random(-0.3, 0.3);
  radie = 50;
  r = random(1);
  g = random(1);
  b = random(1);
  return balls.push(new Ball(radie, x, y, dx, dy, r, g, b));
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsSUFBQSxFQUFBLE1BQUEsRUFBQSxLQUFBLEVBQUEsVUFBQSxFQUFBLElBQUEsRUFBQSxLQUFBLEVBQUEsWUFBQSxFQUFBLEtBQUEsRUFBQSxLQUFBLEVBQUEsS0FBQSxFQUFBOztBQUFBLEtBQUEsR0FBUTs7QUFFUixNQUFBLEdBQVM7O0FBQ1QsS0FBQSxHQUFROztBQUNSLEtBQUEsR0FBUTs7QUFFRixPQUFOLE1BQUEsS0FBQTtFQUNDLFdBQWMsT0FBQSxJQUFBLElBQUEsS0FBQSxLQUFBLElBQUEsSUFBQSxJQUFBLENBQUE7SUFBQyxJQUFDLENBQUE7SUFBTyxJQUFDLENBQUE7SUFBRyxJQUFDLENBQUE7SUFBRyxJQUFDLENBQUE7SUFBSSxJQUFDLENBQUE7SUFBSSxJQUFDLENBQUE7SUFBRyxJQUFDLENBQUE7SUFBRyxJQUFDLENBQUE7SUFDakQsSUFBQyxDQUFBLE1BQUQsR0FBVTtFQURHOztFQUVkLElBQU8sQ0FBQSxDQUFBO0lBQ04sSUFBRyxDQUFJLElBQUMsQ0FBQSxNQUFSO0FBQW9CLGFBQXBCOztJQUNBLElBQUcsSUFBQyxDQUFBLENBQUQsR0FBSyxLQUFBLEdBQU0sSUFBQyxDQUFBLEtBQWY7TUFBMEIsSUFBQyxDQUFBLEVBQUQsR0FBTSxDQUFDLElBQUMsQ0FBQSxHQUFsQzs7SUFDQSxJQUFHLElBQUMsQ0FBQSxDQUFELEdBQUssSUFBQyxDQUFBLEtBQVQ7TUFBb0IsSUFBQyxDQUFBLEVBQUQsR0FBTSxDQUFDLElBQUMsQ0FBQSxHQUE1Qjs7SUFDQSxJQUFDLENBQUEsQ0FBRCxJQUFNLElBQUMsQ0FBQTtJQUVQLElBQUcsSUFBQyxDQUFBLENBQUQsR0FBSyxNQUFBLEdBQU8sSUFBQyxDQUFBLEtBQWhCO01BQTJCLElBQUMsQ0FBQSxFQUFELEdBQU0sQ0FBQyxJQUFDLENB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QUFmLEVBQWlCLENBQWpCLEVBQW1CLEVBQW5CLEVBQXNCLEVBQXRCLEVBQXlCLENBQXpCLEVBQTJCLENBQTNCLEVBQTZCLENBQTdCLENBQVg7QUFYWSIsInNvdXJjZXNDb250ZW50IjpbImxldmVsID0gMFxyXG5cclxuYWN0aXZlID0gMFxyXG5zdGFydCA9IG51bGxcclxuc3RvcHAgPSBudWxsXHJcblxyXG5jbGFzcyBCYWxsXHJcblx0Y29uc3RydWN0b3IgOiAoQHJhZGllLCBAeCwgQHksIEBkeCwgQGR5LCBAciwgQGcsIEBiKSAtPlxyXG5cdFx0QGFjdGl2ZSA9IHRydWVcclxuXHRyaXRhIDogLT5cclxuXHRcdGlmIG5vdCBAYWN0aXZlIHRoZW4gcmV0dXJuIFxyXG5cdFx0aWYgQHggPiB3aWR0aC1AcmFkaWUgdGhlbiBAZHggPSAtQGR4XHJcblx0XHRpZiBAeCA8IEByYWRpZSB0aGVuIEBkeCA9IC1AZHhcclxuXHRcdEB4ICs9IEBkeFxyXG5cclxuXHRcdGlmIEB5ID4gaGVpZ2h0LUByYWRpZSB0aGVuIEBkeSA9IC1AZHkgZWxzZSBAZHkrPTAuMVxyXG5cclxuXHRcdEB5ICs9IEBkeVxyXG5cdFx0ZmMgQHIsQGcsQGJcclxuXHRcdGNpcmNsZSBAeCxAeSxAcmFkaWVcclxuXHRpbnNpZGUgOiAobXgsbXkpIC0+IGRpc3QoQHgsQHksbXgsbXkpIDwgQHJhZGllXHJcblxyXG5iYWxscyA9IFtdXHJcblxyXG5yZXNldCA9ICgpIC0+XHJcblx0c3RhcnQgPSBuZXcgRGF0ZSgpXHJcblx0bGV2ZWwrK1xyXG5cdGJhbGxzID0gW11cclxuXHRmb3IgaSBpbiByYW5nZSBsZXZlbFxyXG5cdFx0Y3JlYXRlQmFsbCgpXHJcblxyXG5zZXR1cCA9IC0+XHJcblx0Y3JlYXRlQ2FudmFzIDgwMCw2MDBcclxuXHRyZXNldCgpXHJcblx0dGV4dFNpemUgMTAwXHJcblx0dGV4dEFsaWduIENFTlRFUixDRU5URVJcclxuXHJcbmRyYXcgPSAtPlxyXG5cdGJnIDBcclxuXHRmb3IgYmFsbCBpbiBiYWxsc1xyXG5cdFx0YmFsbC5yaXRhKClcclxuXHRpZiBhY3RpdmUgPT0gMFxyXG5cdFx0ZmMgMVxyXG5cdFx0dGV4dCAoc3RvcHAtc3RhcnQpLzEwMDAsIHdpZHRoLzIsaGVpZ2h0LzJcclxuXHJcbm1vdXNlUHJlc3NlZCA9IC0+XHJcblx0aWYgYWN0aXZlPT0wXHJcblx0XHRyZXNldCgpXHJcblx0ZWxzZVxyXG5cdFx0Zm9yIGJhbGwgaW4gYmFsbHNcclxuXHRcdFx0aWYgYmFsbC5pbnNpZGUgbW91c2VYLG1vdXNlWSBcclxuXHRcdFx0XHRiYWxsLmFjdGl2ZSA9IGZhbHNlXHJcblx0XHRcdFx0YWN0aXZlLS1cclxuXHRcdFx0XHRpZiBhY3RpdmUgPT0gMFxyXG5cdFx0XHRcdFx0c3RvcHAgPSBuZXcgRGF0ZSgpIFxyXG5cclxuY3JlYXRlQmFsbCA9IC0+XHJcblx0YWN0aXZlKytcclxuXHR4ID0gcmFuZG9tIDUwLHdpZHRoXHJcblx0eSA9IHJhbmRvbSA1MCwxMDBcclxuXHRkeCA9IHJhbmRvbSAtMiwyXHJcblx0ZHkgPSByYW5kb20gLTAuMywwLjNcclxuXHJcblx0cmFkaWUgPSA1MFxyXG5cdHIgPSByYW5kb20gMVxyXG5cdGcgPSByYW5kb20gMVxyXG5cdGIgPSByYW5kb20gMVxyXG5cdGJhbGxzLnB1c2ggbmV3IEJhbGwgcmFkaWUseCx5LGR4LGR5LHIsZyxiXHJcbiJdfQ==
//# sourceURL=c:\Lab\2020\009-Experiment\coffee\sketch.coffee