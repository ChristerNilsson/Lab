// Generated by CoffeeScript 1.11.1
var INNER_RADIUS, LINE_WIDTH, MAX_ARC_ANGLE, MAX_DIAMETER, MAX_RADIUS, MIN_ARC_ANGLE, PALETTE, RADIUS_STEP, circles, createArcs, createCircles, draw, rnd, setup;

MAX_DIAMETER = _.min([innerWidth, innerHeight]);

MAX_RADIUS = MAX_DIAMETER * 0.5;

INNER_RADIUS = 100;

LINE_WIDTH = 2;

RADIUS_STEP = 6;

MIN_ARC_ANGLE = 18;

MAX_ARC_ANGLE = 36;

PALETTE = '#2D0F0E #CE0010 #65223D #D14E34 #EEAA40 #7E8A65 #4C3C49 #972448 #E69651 #EEDDA8'.split(' ');

rnd = function(x) {
  return Math.random() * x;
};

circles = [];

setup = function() {
  createCanvas(MAX_DIAMETER, MAX_DIAMETER);
  createCircles();
  fc();
  return sw(LINE_WIDTH);
};

draw = function() {
  var i, j, k, l, len, len1, offset, points, r, ref, ref1, results, speed, start, stopp;
  background(PALETTE[0]);
  translate(width / 2, height / 2);
  results = [];
  for (j = k = 0, len = circles.length; k < len; j = ++k) {
    ref = circles[j], points = ref[0], offset = ref[1], speed = ref[2];
    r = INNER_RADIUS + j * RADIUS_STEP;
    ref1 = range(points.length - 1);
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      i = ref1[l];
      stroke(PALETTE[i % 10]);
      start = offset + points[i];
      stopp = offset + points[i + 1];
      arc(0, 0, 2 * r, 2 * r, start, stopp);
    }
    results.push(circles[j][1] += speed);
  }
  return results;
};

createCircles = function() {
  var i, k, len, ref, results;
  ref = range(100);
  results = [];
  for (k = 0, len = ref.length; k < len; k++) {
    i = ref[k];
    results.push(circles.push([createArcs(), radians(rnd(360)), radians(-0.5 + rnd(1))]));
  }
  return results;
};

createArcs = function() {
  var d, points, step;
  points = [0];
  d = 0;
  while (d < 324) {
    step = MIN_ARC_ANGLE + rnd(MAX_ARC_ANGLE - MIN_ARC_ANGLE);
    d += step;
    points.push(radians(d));
  }
  points.push(radians(360));
  return points;
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUE7O0FBQUEsWUFBQSxHQUFlLENBQUMsQ0FBQyxHQUFGLENBQU0sQ0FBQyxVQUFELEVBQVksV0FBWixDQUFOOztBQUNmLFVBQUEsR0FBYSxZQUFBLEdBQWU7O0FBQzVCLFlBQUEsR0FBZTs7QUFDZixVQUFBLEdBQWE7O0FBQ2IsV0FBQSxHQUFjOztBQUNkLGFBQUEsR0FBZ0I7O0FBQ2hCLGFBQUEsR0FBZ0I7O0FBQ2hCLE9BQUEsR0FBVSxpRkFBaUYsQ0FBQyxLQUFsRixDQUF3RixHQUF4Rjs7QUFFVixHQUFBLEdBQU0sU0FBQyxDQUFEO1NBQU8sSUFBSSxDQUFDLE1BQUwsQ0FBQSxDQUFBLEdBQWdCO0FBQXZCOztBQUVOLE9BQUEsR0FBVTs7QUFFVixLQUFBLEdBQVEsU0FBQTtFQUNQLFlBQUEsQ0FBYSxZQUFiLEVBQTBCLFlBQTFCO0VBQ0EsYUFBQSxDQUFBO0VBQ0EsRUFBQSxDQUFBO1NBQ0EsRUFBQSxDQUFHLFVBQUg7QUFKTzs7QUFNUixJQUFBLEdBQU8sU0FBQTtBQUNOLE1BQUE7RUFBQSxVQUFBLENBQVcsT0FBUSxDQUFBLENBQUEsQ0FBbkI7RUFDQSxTQUFBLENBQVUsS0FBQSxHQUFNLENBQWhCLEVBQW1CLE1BQUEsR0FBTyxDQUExQjtBQUNBO09BQUEsaURBQUE7c0JBQUssaUJBQU8saUJBQU87SUFDbEIsQ0FBQSxHQUFJLFlBQUEsR0FBZSxDQUFBLEdBQUk7QUFDdkI7QUFBQSxTQUFBLHdDQUFBOztNQUNDLE1BQUEsQ0FBTyxPQUFRLENBQUEsQ0FBQSxHQUFFLEVBQUYsQ0FBZjtNQUNBLEtBQUEsR0FBUSxNQUFBLEdBQU8sTUFBTyxDQUFBLENBQUE7TUFDdEIsS0FBQSxHQUFRLE1BQUEsR0FBTyxNQUFPLENBQUEsQ0FBQSxHQUFFLENBQUY7TUFDdEIsR0FBQSxDQUFJLENBQUosRUFBTSxDQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVgsRUFBYSxDQUFBLEdBQUUsQ0FBZixFQUFrQixLQUFsQixFQUF3QixLQUF4QjtBQUpEO2lCQUtBLE9BQVEsQ0FBQSxDQUFBLENBQUcsQ0FBQSxDQUFBLENBQVgsSUFBaUI7QUFQbEI7O0FBSE07O0FBWVAsYUFBQSxHQUFnQixTQUFBO0FBQ2YsTUFBQTtBQUFBO0FBQUE7T0FBQSxxQ0FBQTs7aUJBQ0MsT0FBTyxDQUFDLElBQVIsQ0FBYSxDQUFDLFVBQUEsQ0FBQSxDQUFELEVBQWUsT0FBQSxDQUFRLEdBQUEsQ0FBSSxHQUFKLENBQVIsQ0FBZixFQUFpQyxPQUFBLENBQVEsQ0FBQyxHQUFELEdBQU8sR0FBQSxDQUFJLENBQUosQ0FBZixDQUFqQyxDQUFiO0FBREQ7O0FBRGU7O0FBSWhCLFVBQUEsR0FBYSxTQUFBO0FBQ1osTUFBQTtFQUFBLE1BQUEsR0FBUyxDQUFDLENBQUQ7RUFDVCxDQUFBLEdBQUk7QUFDSixTQUFNLENBQUEsR0FBSSxHQUFWO0lBQ0MsSUFBQSxHQUFPLGFBQUEsR0FBZ0IsR0FBQSxDQUFJLGFBQUEsR0FBZ0IsYUFBcEI7SUFDdkIsQ0FBQSxJQUFLO0lBQ0wsTUFBTSxDQUFDLElBQVAsQ0FBWSxPQUFBLENBQVEsQ0FBUixDQUFaO0VBSEQ7RUFJQSxNQUFNLENBQUMsSUFBUCxDQUFZLE9BQUEsQ0FBUSxHQUFSLENBQVo7U0FDQTtBQVJZIiwic291cmNlc0NvbnRlbnQiOlsiTUFYX0RJQU1FVEVSID0gXy5taW4gW2lubmVyV2lkdGgsaW5uZXJIZWlnaHRdXHJcbk1BWF9SQURJVVMgPSBNQVhfRElBTUVURVIgKiAwLjVcclxuSU5ORVJfUkFESVVTID0gMTAwXHJcbkxJTkVfV0lEVEggPSAyXHJcblJBRElVU19TVEVQID0gNlxyXG5NSU5fQVJDX0FOR0xFID0gMThcclxuTUFYX0FSQ19BTkdMRSA9IDM2XHJcblBBTEVUVEUgPSAnIzJEMEYwRSAjQ0UwMDEwICM2NTIyM0QgI0QxNEUzNCAjRUVBQTQwICM3RThBNjUgIzRDM0M0OSAjOTcyNDQ4ICNFNjk2NTEgI0VFRERBOCcuc3BsaXQgJyAnXHJcblxyXG5ybmQgPSAoeCkgLT4gTWF0aC5yYW5kb20oKSAqIHhcclxuXHJcbmNpcmNsZXMgPSBbXVxyXG5cclxuc2V0dXAgPSAtPlxyXG5cdGNyZWF0ZUNhbnZhcyBNQVhfRElBTUVURVIsTUFYX0RJQU1FVEVSXHJcblx0Y3JlYXRlQ2lyY2xlcygpXHJcblx0ZmMoKVxyXG5cdHN3IExJTkVfV0lEVEhcclxuXHJcbmRyYXcgPSAtPlxyXG5cdGJhY2tncm91bmQgUEFMRVRURVswXVxyXG5cdHRyYW5zbGF0ZSB3aWR0aC8yLCBoZWlnaHQvMlxyXG5cdGZvciBbcG9pbnRzLG9mZnNldCxzcGVlZF0saiBpbiBjaXJjbGVzXHJcblx0XHRyID0gSU5ORVJfUkFESVVTICsgaiAqIFJBRElVU19TVEVQXHJcblx0XHRmb3IgaSBpbiByYW5nZSBwb2ludHMubGVuZ3RoLTFcclxuXHRcdFx0c3Ryb2tlIFBBTEVUVEVbaSUxMF1cclxuXHRcdFx0c3RhcnQgPSBvZmZzZXQrcG9pbnRzW2ldXHJcblx0XHRcdHN0b3BwID0gb2Zmc2V0K3BvaW50c1tpKzFdXHJcblx0XHRcdGFyYyAwLDAsIDIqciwyKnIsIHN0YXJ0LHN0b3BwXHJcblx0XHRjaXJjbGVzW2pdWzFdICs9IHNwZWVkXHJcblxyXG5jcmVhdGVDaXJjbGVzID0gLT5cclxuXHRmb3IgaSBpbiByYW5nZSAxMDBcclxuXHRcdGNpcmNsZXMucHVzaCBbY3JlYXRlQXJjcygpLFx0cmFkaWFucyhybmQgMzYwKSwgcmFkaWFucygtMC41ICsgcm5kIDEpXVxyXG5cclxuY3JlYXRlQXJjcyA9IC0+XHJcblx0cG9pbnRzID0gWzBdXHJcblx0ZCA9IDBcclxuXHR3aGlsZSBkIDwgMzI0XHJcblx0XHRzdGVwID0gTUlOX0FSQ19BTkdMRSArIHJuZCBNQVhfQVJDX0FOR0xFIC0gTUlOX0FSQ19BTkdMRVxyXG5cdFx0ZCArPSBzdGVwXHJcblx0XHRwb2ludHMucHVzaCByYWRpYW5zIGRcclxuXHRwb2ludHMucHVzaCByYWRpYW5zIDM2MFxyXG5cdHBvaW50cyJdfQ==
//# sourceURL=C:\Lab\2017\083-Concentrics\coffee\sketch.coffee