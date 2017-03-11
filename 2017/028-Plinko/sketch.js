// Generated by CoffeeScript 1.11.1
var Bodies, Engine, Events, World, bounds, cols, draw, engine, newParticle, particles, plinkos, rows, setup, world;

Engine = Matter.Engine;

World = Matter.World;

Events = Matter.Events;

Bodies = Matter.Bodies;

engine = null;

world = null;

particles = [];

plinkos = [];

bounds = [];

cols = 11;

rows = 10;

setup = function() {
  var b, h, i, j, k, l, len, len1, len2, m, p, ref, ref1, ref2, results, spacing, w, x, y;
  createCanvas(600, 700);
  colorMode(HSB);
  engine = Engine.create();
  world = engine.world;
  newParticle();
  spacing = width / cols;
  ref = range(rows);
  for (k = 0, len = ref.length; k < len; k++) {
    j = ref[k];
    ref1 = range(cols);
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      i = ref1[l];
      x = i * spacing;
      if (j % 2 === 0) {
        x += spacing / 2;
      }
      y = spacing + j * spacing;
      p = new Plinko(x, y, 16);
      plinkos.push(p);
    }
  }
  b = new Boundary(width / 2, height + 50, width, 100);
  bounds.push(b);
  ref2 = range(cols);
  results = [];
  for (m = 0, len2 = ref2.length; m < len2; m++) {
    i = ref2[m];
    x = i * spacing;
    h = 100;
    w = 10;
    y = height - h / 2;
    b = new Boundary(x, y, w, h);
    results.push(bounds.push(b));
  }
  return results;
};

newParticle = function() {
  var p;
  p = new Particle(300, 0, 10);
  return particles.push(p);
};

draw = function() {
  var bound, k, l, len, len1, len2, m, particle, plinko, results;
  background(0, 0, 0);
  if (frameCount % 20 === 0) {
    newParticle();
  }
  Engine.update(engine, 1000 / 30);
  for (k = 0, len = particles.length; k < len; k++) {
    particle = particles[k];
    particle.show();
    if (particle.isOffScreen()) {
      World.remove(world, particle.body);
      particles.splice(i, 1);
      i--;
    }
  }
  for (l = 0, len1 = plinkos.length; l < len1; l++) {
    plinko = plinkos[l];
    plinko.show();
  }
  results = [];
  for (m = 0, len2 = bounds.length; m < len2; m++) {
    bound = bounds[m];
    results.push(bound.show());
  }
  return results;
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsic2tldGNoLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQTs7QUFBQSxNQUFBLEdBQVMsTUFBTSxDQUFDOztBQUNoQixLQUFBLEdBQVEsTUFBTSxDQUFDOztBQUNmLE1BQUEsR0FBUyxNQUFNLENBQUM7O0FBQ2hCLE1BQUEsR0FBUyxNQUFNLENBQUM7O0FBRWhCLE1BQUEsR0FBTzs7QUFDUCxLQUFBLEdBQU07O0FBQ04sU0FBQSxHQUFZOztBQUNaLE9BQUEsR0FBVTs7QUFDVixNQUFBLEdBQVM7O0FBQ1QsSUFBQSxHQUFPOztBQUNQLElBQUEsR0FBTzs7QUFJUCxLQUFBLEdBQVEsU0FBQTtBQUNOLE1BQUE7RUFBQSxZQUFBLENBQWEsR0FBYixFQUFrQixHQUFsQjtFQUNBLFNBQUEsQ0FBVSxHQUFWO0VBQ0EsTUFBQSxHQUFTLE1BQU0sQ0FBQyxNQUFQLENBQUE7RUFDVCxLQUFBLEdBQVEsTUFBTSxDQUFDO0VBYWYsV0FBQSxDQUFBO0VBQ0EsT0FBQSxHQUFVLEtBQUEsR0FBUTtBQUNsQjtBQUFBLE9BQUEscUNBQUE7O0FBQ0U7QUFBQSxTQUFBLHdDQUFBOztNQUNFLENBQUEsR0FBSSxDQUFBLEdBQUk7TUFDUixJQUFHLENBQUEsR0FBSSxDQUFKLEtBQVMsQ0FBWjtRQUFtQixDQUFBLElBQUssT0FBQSxHQUFVLEVBQWxDOztNQUNBLENBQUEsR0FBSSxPQUFBLEdBQVUsQ0FBQSxHQUFJO01BQ2xCLENBQUEsR0FBUSxJQUFBLE1BQUEsQ0FBTyxDQUFQLEVBQVUsQ0FBVixFQUFhLEVBQWI7TUFDUixPQUFPLENBQUMsSUFBUixDQUFhLENBQWI7QUFMRjtBQURGO0VBUUEsQ0FBQSxHQUFRLElBQUEsUUFBQSxDQUFTLEtBQUEsR0FBUSxDQUFqQixFQUFvQixNQUFBLEdBQVMsRUFBN0IsRUFBaUMsS0FBakMsRUFBd0MsR0FBeEM7RUFDUixNQUFNLENBQUMsSUFBUCxDQUFZLENBQVo7QUFFQTtBQUFBO09BQUEsd0NBQUE7O0lBQ0UsQ0FBQSxHQUFJLENBQUEsR0FBSTtJQUNSLENBQUEsR0FBSTtJQUNKLENBQUEsR0FBSTtJQUNKLENBQUEsR0FBSSxNQUFBLEdBQVMsQ0FBQSxHQUFJO0lBQ2pCLENBQUEsR0FBUSxJQUFBLFFBQUEsQ0FBUyxDQUFULEVBQVksQ0FBWixFQUFlLENBQWYsRUFBa0IsQ0FBbEI7aUJBQ1IsTUFBTSxDQUFDLElBQVAsQ0FBWSxDQUFaO0FBTkY7O0FBOUJNOztBQXNDUixXQUFBLEdBQWMsU0FBQTtBQUNaLE1BQUE7RUFBQSxDQUFBLEdBQVEsSUFBQSxRQUFBLENBQVMsR0FBVCxFQUFjLENBQWQsRUFBaUIsRUFBakI7U0FDUixTQUFTLENBQUMsSUFBVixDQUFlLENBQWY7QUFGWTs7QUFJZCxJQUFBLEdBQU8sU0FBQTtBQUNMLE1BQUE7RUFBQSxVQUFBLENBQVcsQ0FBWCxFQUFjLENBQWQsRUFBaUIsQ0FBakI7RUFDQSxJQUFHLFVBQUEsR0FBYSxFQUFiLEtBQW1CLENBQXRCO0lBQTZCLFdBQUEsQ0FBQSxFQUE3Qjs7RUFDQSxNQUFNLENBQUMsTUFBUCxDQUFjLE1BQWQsRUFBc0IsSUFBQSxHQUFPLEVBQTdCO0FBQ0EsT0FBQSwyQ0FBQTs7SUFDRSxRQUFRLENBQUMsSUFBVCxDQUFBO0lBQ0EsSUFBRyxRQUFRLENBQUMsV0FBVCxDQUFBLENBQUg7TUFDRSxLQUFLLENBQUMsTUFBTixDQUFhLEtBQWIsRUFBb0IsUUFBUSxDQUFDLElBQTdCO01BQ0EsU0FBUyxDQUFDLE1BQVYsQ0FBaUIsQ0FBakIsRUFBb0IsQ0FBcEI7TUFDQSxDQUFBLEdBSEY7O0FBRkY7QUFNQSxPQUFBLDJDQUFBOztJQUFBLE1BQU0sQ0FBQyxJQUFQLENBQUE7QUFBQTtBQUNBO09BQUEsMENBQUE7O2lCQUFBLEtBQUssQ0FBQyxJQUFOLENBQUE7QUFBQTs7QUFYSyIsInNvdXJjZXNDb250ZW50IjpbIkVuZ2luZSA9IE1hdHRlci5FbmdpbmVcclxuV29ybGQgPSBNYXR0ZXIuV29ybGRcclxuRXZlbnRzID0gTWF0dGVyLkV2ZW50c1xyXG5Cb2RpZXMgPSBNYXR0ZXIuQm9kaWVzXHJcblxyXG5lbmdpbmU9bnVsbFxyXG53b3JsZD1udWxsXHJcbnBhcnRpY2xlcyA9IFtdXHJcbnBsaW5rb3MgPSBbXVxyXG5ib3VuZHMgPSBbXVxyXG5jb2xzID0gMTFcclxucm93cyA9IDEwXHJcblxyXG4jcHJlbG9hZCA9IC0+IGRpbmcgPSBsb2FkU291bmQgJ2RpbmcubXAzJ1xyXG5cclxuc2V0dXAgPSAtPlxyXG4gIGNyZWF0ZUNhbnZhcyA2MDAsIDcwMFxyXG4gIGNvbG9yTW9kZSBIU0JcclxuICBlbmdpbmUgPSBFbmdpbmUuY3JlYXRlKClcclxuICB3b3JsZCA9IGVuZ2luZS53b3JsZFxyXG4gICN3b3JsZC5ncmF2aXR5LnkgPSAyO1xyXG5cclxuICAjY29sbGlzaW9uID0gKGV2ZW50KSAtPlxyXG4gICAgI3BhaXJzID0gZXZlbnQucGFpcnNcclxuICAgICNmb3IgcGFpciBpbiBwYWlycyBcclxuICAgICAgI2xhYmVsQSA9IHBhaXIuYm9keUEubGFiZWxcclxuICAgICAgI2xhYmVsQiA9IHBhaXIuYm9keUIubGFiZWxcclxuICAgICAgI2lmIGxhYmVsQSA9PSAncGFydGljbGUnIGFuZCBsYWJlbEIgPT0gJ3BsaW5rbycgdGhlbiBkaW5nLnBsYXkoKVxyXG4gICAgICAjaWYgbGFiZWxBID09ICdwbGlua28nIGFuZCBsYWJlbEIgPT0gJ3BhcnRpY2xlJyB0aGVuIGRpbmcucGxheSgpXHJcblxyXG4gICNFdmVudHMub24gZW5naW5lLCAnY29sbGlzaW9uU3RhcnQnLCBjb2xsaXNpb25cclxuXHJcbiAgbmV3UGFydGljbGUoKTtcclxuICBzcGFjaW5nID0gd2lkdGggLyBjb2xzXHJcbiAgZm9yIGogaW4gcmFuZ2Ugcm93c1xyXG4gICAgZm9yIGkgaW4gcmFuZ2UgY29sc1xyXG4gICAgICB4ID0gaSAqIHNwYWNpbmdcclxuICAgICAgaWYgaiAlIDIgPT0gMCB0aGVuIHggKz0gc3BhY2luZyAvIDJcclxuICAgICAgeSA9IHNwYWNpbmcgKyBqICogc3BhY2luZ1xyXG4gICAgICBwID0gbmV3IFBsaW5rbyB4LCB5LCAxNlxyXG4gICAgICBwbGlua29zLnB1c2ggcFxyXG5cclxuICBiID0gbmV3IEJvdW5kYXJ5IHdpZHRoIC8gMiwgaGVpZ2h0ICsgNTAsIHdpZHRoLCAxMDBcclxuICBib3VuZHMucHVzaCBiXHJcblxyXG4gIGZvciBpIGluIHJhbmdlIGNvbHNcclxuICAgIHggPSBpICogc3BhY2luZ1xyXG4gICAgaCA9IDEwMFxyXG4gICAgdyA9IDEwXHJcbiAgICB5ID0gaGVpZ2h0IC0gaCAvIDJcclxuICAgIGIgPSBuZXcgQm91bmRhcnkgeCwgeSwgdywgaFxyXG4gICAgYm91bmRzLnB1c2ggYlxyXG5cclxubmV3UGFydGljbGUgPSAtPlxyXG4gIHAgPSBuZXcgUGFydGljbGUgMzAwLCAwLCAxMFxyXG4gIHBhcnRpY2xlcy5wdXNoIHBcclxuXHJcbmRyYXcgPSAtPlxyXG4gIGJhY2tncm91bmQgMCwgMCwgMFxyXG4gIGlmIGZyYW1lQ291bnQgJSAyMCA9PSAwIHRoZW4gbmV3UGFydGljbGUoKVxyXG4gIEVuZ2luZS51cGRhdGUgZW5naW5lLCAxMDAwIC8gMzBcclxuICBmb3IgcGFydGljbGUgaW4gcGFydGljbGVzXHJcbiAgICBwYXJ0aWNsZS5zaG93KClcclxuICAgIGlmIHBhcnRpY2xlLmlzT2ZmU2NyZWVuKClcclxuICAgICAgV29ybGQucmVtb3ZlIHdvcmxkLCBwYXJ0aWNsZS5ib2R5XHJcbiAgICAgIHBhcnRpY2xlcy5zcGxpY2UgaSwgMVxyXG4gICAgICBpLS1cclxuICBwbGlua28uc2hvdygpIGZvciBwbGlua28gaW4gcGxpbmtvc1xyXG4gIGJvdW5kLnNob3coKSBmb3IgYm91bmQgaW4gYm91bmRzICAgICAiXX0=
//# sourceURL=C:\Lab\2017\028-Plinko\sketch.coffee