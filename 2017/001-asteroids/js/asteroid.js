// Generated by CoffeeScript 1.12.7
var Asteroid;

Asteroid = (function() {
  function Asteroid(pos, r1) {
    var i, j, len, ref;
    this.pos = pos != null ? pos : new p5.Vector(random(width), random(height));
    this.r = r1 != null ? r1 : 15 + random(20);
    this.offset = [];
    this.total = 5 + random(10);
    ref = range(this.total);
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      this.offset.push(0.7 + random(0.6));
    }
    this.vel = p5.Vector.random2D();
  }

  Asteroid.prototype.update = function() {
    this.pos.add(this.vel);
    this.pos.x = modulo(this.pos.x, width);
    return this.pos.y = modulo(this.pos.y, height);
  };

  Asteroid.prototype.hit = function(body) {
    return body.r + this.r > dist(body.pos.x, body.pos.y, this.pos.x, this.pos.y);
  };

  Asteroid.prototype.draw = function() {
    var angle, i, j, len, r, ref, x, y;
    push();
    stroke(255);
    strokeWeight(1);
    noFill();
    translate(this.pos.x, this.pos.y);
    beginShape();
    ref = range(this.total);
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      angle = map(i, 0, this.total, 0, TWO_PI);
      r = this.r * this.offset[i];
      x = r * cos(angle);
      y = r * sin(angle);
      vertex(x, y);
    }
    endShape(CLOSE);
    return pop();
  };

  return Asteroid;

})();

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiYXN0ZXJvaWQuanMiLCJzb3VyY2VSb290IjoiLi4iLCJzb3VyY2VzIjpbImNvZmZlZVxcYXN0ZXJvaWQuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxJQUFBOztBQUFNO0VBQ1Msa0JBQUMsR0FBRCxFQUFxRCxFQUFyRDtBQUNiLFFBQUE7SUFEYyxJQUFDLENBQUEsb0JBQUQsTUFBTyxJQUFJLEVBQUUsQ0FBQyxNQUFQLENBQWMsTUFBQSxDQUFPLEtBQVAsQ0FBZCxFQUE0QixNQUFBLENBQU8sTUFBUCxDQUE1QjtJQUE2QyxJQUFDLENBQUEsaUJBQUQsS0FBRyxFQUFBLEdBQUcsTUFBQSxDQUFPLEVBQVA7SUFDeEUsSUFBQyxDQUFBLE1BQUQsR0FBVTtJQUNWLElBQUMsQ0FBQSxLQUFELEdBQVMsQ0FBQSxHQUFJLE1BQUEsQ0FBTyxFQUFQO0FBQ2I7QUFBQSxTQUFBLHFDQUFBOztNQUNDLElBQUMsQ0FBQSxNQUFNLENBQUMsSUFBUixDQUFhLEdBQUEsR0FBTSxNQUFBLENBQU8sR0FBUCxDQUFuQjtBQUREO0lBRUEsSUFBQyxDQUFBLEdBQUQsR0FBTyxFQUFFLENBQUMsTUFBTSxDQUFDLFFBQVYsQ0FBQTtFQUxNOztxQkFPZCxNQUFBLEdBQVMsU0FBQTtJQUNSLElBQUMsQ0FBQSxHQUFHLENBQUMsR0FBTCxDQUFTLElBQUMsQ0FBQSxHQUFWO0lBQ0EsSUFBQyxDQUFBLEdBQUcsQ0FBQyxDQUFMLEdBQVMsTUFBQSxDQUFPLElBQUMsQ0FBQSxHQUFHLENBQUMsQ0FBWixFQUFlLEtBQWY7V0FDVCxJQUFDLENBQUEsR0FBRyxDQUFDLENBQUwsR0FBUyxNQUFBLENBQU8sSUFBQyxDQUFBLEdBQUcsQ0FBQyxDQUFaLEVBQWUsTUFBZjtFQUhEOztxQkFLVCxHQUFBLEdBQU0sU0FBQyxJQUFEO1dBQVUsSUFBSSxDQUFDLENBQUwsR0FBUyxJQUFDLENBQUEsQ0FBVixHQUFjLElBQUEsQ0FBSyxJQUFJLENBQUMsR0FBRyxDQUFDLENBQWQsRUFBaUIsSUFBSSxDQUFDLEdBQUcsQ0FBQyxDQUExQixFQUE2QixJQUFDLENBQUEsR0FBRyxDQUFDLENBQWxDLEVBQXFDLElBQUMsQ0FBQSxHQUFHLENBQUMsQ0FBMUM7RUFBeEI7O3FCQUVOLElBQUEsR0FBTyxTQUFBO0FBQ04sUUFBQTtJQUFBLElBQUEsQ0FBQTtJQUNBLE1BQUEsQ0FBTyxHQUFQO0lBQ0EsWUFBQSxDQUFhLENBQWI7SUFDQSxNQUFBLENBQUE7SUFDQSxTQUFBLENBQVUsSUFBQyxDQUFBLEdBQUcsQ0FBQyxDQUFmLEVBQWlCLElBQUMsQ0FBQSxHQUFHLENBQUMsQ0FBdEI7SUFDQSxVQUFBLENBQUE7QUFDQTtBQUFBLFNBQUEscUNBQUE7O01BQ0MsS0FBQSxHQUFRLEdBQUEsQ0FBSSxDQUFKLEVBQU8sQ0FBUCxFQUFVLElBQUMsQ0FBQSxLQUFYLEVBQWtCLENBQWxCLEVBQXFCLE1BQXJCO01BQ1IsQ0FBQSxHQUFJLElBQUMsQ0FBQSxDQUFELEdBQUssSUFBQyxDQUFBLE1BQU8sQ0FBQSxDQUFBO01BQ2pCLENBQUEsR0FBSSxDQUFBLEdBQUksR0FBQSxDQUFJLEtBQUo7TUFDUixDQUFBLEdBQUksQ0FBQSxHQUFJLEdBQUEsQ0FBSSxLQUFKO01BQ1IsTUFBQSxDQUFPLENBQVAsRUFBVSxDQUFWO0FBTEQ7SUFNQSxRQUFBLENBQVMsS0FBVDtXQUNBLEdBQUEsQ0FBQTtFQWRNIiwic291cmNlc0NvbnRlbnQiOlsiY2xhc3MgQXN0ZXJvaWRcclxuXHRjb25zdHJ1Y3RvciA6IChAcG9zID0gbmV3IHA1LlZlY3RvcihyYW5kb20od2lkdGgpLHJhbmRvbShoZWlnaHQpKSwgQHI9MTUrcmFuZG9tKDIwKSktPlxyXG5cdFx0QG9mZnNldCA9IFtdXHJcblx0XHRAdG90YWwgPSA1ICsgcmFuZG9tIDEwXHJcblx0XHRmb3IgaSBpbiByYW5nZSBAdG90YWxcclxuXHRcdFx0QG9mZnNldC5wdXNoIDAuNyArIHJhbmRvbSAwLjZcclxuXHRcdEB2ZWwgPSBwNS5WZWN0b3IucmFuZG9tMkQoKVxyXG5cclxuXHR1cGRhdGUgOiAtPlxyXG5cdFx0QHBvcy5hZGQgQHZlbFxyXG5cdFx0QHBvcy54ID0gbW9kdWxvIEBwb3MueCwgd2lkdGhcclxuXHRcdEBwb3MueSA9IG1vZHVsbyBAcG9zLnksIGhlaWdodFxyXG5cclxuXHRoaXQgOiAoYm9keSkgLT4gYm9keS5yICsgQHIgPiBkaXN0IGJvZHkucG9zLngsIGJvZHkucG9zLnksIEBwb3MueCwgQHBvcy55XHJcblxyXG5cdGRyYXcgOiAtPlxyXG5cdFx0cHVzaCgpXHJcblx0XHRzdHJva2UgMjU1XHJcblx0XHRzdHJva2VXZWlnaHQgMVxyXG5cdFx0bm9GaWxsKClcclxuXHRcdHRyYW5zbGF0ZSBAcG9zLngsQHBvcy55XHJcblx0XHRiZWdpblNoYXBlKClcclxuXHRcdGZvciBpIGluIHJhbmdlIEB0b3RhbFxyXG5cdFx0XHRhbmdsZSA9IG1hcCBpLCAwLCBAdG90YWwsIDAsIFRXT19QSVxyXG5cdFx0XHRyID0gQHIgKiBAb2Zmc2V0W2ldXHJcblx0XHRcdHggPSByICogY29zIGFuZ2xlIFxyXG5cdFx0XHR5ID0gciAqIHNpbiBhbmdsZVxyXG5cdFx0XHR2ZXJ0ZXggeCwgeVxyXG5cdFx0ZW5kU2hhcGUgQ0xPU0VcclxuXHRcdHBvcCgpIl19
//# sourceURL=C:\Lab\2017\001-asteroids\coffee\asteroid.coffee