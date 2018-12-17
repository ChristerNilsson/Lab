"use strict";

// Generated by CoffeeScript 2.3.2
var draw, mousePressed, n, pause, setup, times;

times = 0;

n = null;

pause = false;

setup = function setup() {
  createCanvas(windowWidth, windowHeight);
  n = round(height * 0.49);
  angleMode(DEGREES);
  return sw(1 / n);
};

draw = function draw() {
  var i, j, len, ref, x1, x2, y1, y2;
  bg(0);
  sc(1, 0, 0, 0.5);
  translate(width / 2, height / 2);
  scale(n);
  ref = range(360);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    x1 = cos(i);
    y1 = sin(i);
    x2 = cos(i * times / 2000);
    y2 = sin(i * times / 2000);
    line(x1, y1, x2, y2);
  }
  if (!pause) {
    return times++;
  }
};

mousePressed = function mousePressed() {
  if (n > dist(n, n, mouseX, mouseY)) {
    return pause = !pause;
  } else if (mouseX < n) {
    return times--;
  } else {
    return times++;
  }
};
//# sourceMappingURL=sketch.js.map
