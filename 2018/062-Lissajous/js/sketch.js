"use strict";

// Generated by CoffeeScript 2.0.3
var angle, cols, curves, draw, make2DArray, reset, rows, setup, w;

make2DArray = function make2DArray(rows, cols) {
  var arr, i, l, len, ref;
  arr = new Array(rows);
  ref = range(arr.length);
  for (l = 0, len = ref.length; l < len; l++) {
    i = ref[l];
    arr[i] = new Array(cols);
  }
  return arr;
};

w = 120;

angle = null;

cols = null;

rows = null;

curves = null;

setup = function setup() {
  createCanvas(windowWidth, windowHeight);
  angleMode(DEGREES);
  cols = Math.floor(width / w);
  rows = Math.floor(height / w);
  curves = make2DArray(rows, cols);
  return reset();
};

reset = function reset() {
  var i, j, l, len, ref, results;
  angle = 0;
  ref = range(rows);
  results = [];
  for (l = 0, len = ref.length; l < len; l++) {
    j = ref[l];
    results.push(function () {
      var len1, m, ref1, results1;
      ref1 = range(cols);
      results1 = [];
      for (m = 0, len1 = ref1.length; m < len1; m++) {
        i = ref1[m];
        results1.push(curves[j][i] = new Curve());
      }
      return results1;
    }());
  }
  return results;
};

draw = function draw() {
  var cx, cy, i, j, k, l, len, len1, m, r, ref, ref1, x, y;
  bg(0);
  r = 0.4 * w;
  noFill();
  ref = range(rows);
  for (l = 0, len = ref.length; l < len; l++) {
    j = ref[l];
    ref1 = range(cols);
    for (m = 0, len1 = ref1.length; m < len1; m++) {
      i = ref1[m];
      cy = (j + 0.5) * w;
      cx = (i + 0.5) * w;
      if (i === 0 && j === 0) {} else if (i === 0 || j === 0) {
        sw(1);
        circle(cx, cy, r);
        k = i === 0 ? j : i;
        y = cy + r * sin(angle * k - 90);
        x = cx + r * cos(angle * k - 90);
        if (j === 0) {
          line(x, 0, x, height);
        }
        if (i === 0) {
          line(0, y, width, y);
        }
        sw(8);
        point(x, y);
      } else {
        sw(1);
        stroke(255, 50);
        y = cy + r * sin(angle * j - 90);
        x = cx + r * cos(angle * i - 90);
        curves[j][i].addPoint(x, y);
        curves[j][i].show();
      }
    }
  }
  if (angle === 360) {
    return reset();
  } else {
    return angle++;
  }
};
//# sourceMappingURL=sketch.js.map
