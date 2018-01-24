'use strict';

// Generated by CoffeeScript 2.0.3
// Portrait
var drawCompassP, drawHouseP, drawNeedleP, drawTextsP;

drawHouseP = function drawHouseP(w, h, radius) {
  var dx, i, j, k, len, len1, ref, ref1;
  push();
  // nio linjer
  dx = 0.02 * w;
  sc(0);
  sw(1);
  ref = range(-4, 5);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    line(i * 4 * dx, -1.1 * radius, i * 4 * dx, 1.1 * radius);
  }
  // vit omkrets
  sc(1);
  sw(5);
  fc();
  circle(0, 0, 1.1 * radius);
  // svarta pilen
  sc(0);
  sw(0.05 * h);
  line(0, -1.00 * radius, 0, 1.00 * radius);
  // fyra väderstreck
  sc();
  textAlign(CENTER, CENTER);
  textSize(0.06 * h);
  ref1 = range(4);
  for (k = 0, len1 = ref1.length; k < len1; k++) {
    i = ref1[k];
    push();
    translate(0, 0.96 * radius);
    rd(180);
    if (i === 0) {
      fc(1);
    } else if (i === 2) {
      fc(1, 0, 0);
    } else {
      fc(0);
    }
    text("SWNE"[i], 0, 0);
    pop();
    rd(90);
  }
  return pop();
};

drawNeedleP = function drawNeedleP(w, h, radius) {
  try {
    rd(-bearing + 90);
    //rd bearing - 90
    sc(0);
    sw(0.035 * h);
    line(0, -0.98 * radius, 0, 0.98 * radius);
    sc(1);
    sw(0.030 * h);
    line(0, 0, 0.98 * radius, 0);
    sc(1, 0, 0);
    line(0, 0, -0.98 * radius, 0);
    sw(0.035 * h);
    sc(0);
    return point(0, 0);
  } catch (error) {}
};

drawCompassP = function drawCompassP(w, h) {
  var delta, radius;
  radius = 0.37 * w;
  delta = calcDelta(bearing - heading_12);
  fill(calcColor(delta));
  sw(5);
  sc(1);
  push();
  translate(0.5 * w, 0.5 * h);
  circle(0, 0, 1.1 * radius);
  push();
  rd(-heading_12);
  drawHouseP(w, h, radius);
  pop();
  drawNeedleP(w, h, radius);
  return pop();
};

drawTextsP = function drawTextsP(w, h) {
  var currTexts, d, i, j, len, n, t, x, y;
  fc(0.5);
  d = h / 12;
  sc(0.5);
  sw(1);
  n = 3; // columns
  if (millis() - start < 1000) {
    textSize(h * 0.07);
    currTexts = ['Distance', 'Bearing', 'ETA', 'Speed', '', 'Time', 'Points', '', 'Delay', 'Destination'];
  } else {
    textSize(h * 0.05);
    currTexts = texts;
  }
  for (i = j = 0, len = currTexts.length; j < len; i = ++j) {
    t = currTexts[i];
    if (i % n === 0) {
      textAlign(LEFT);
    }
    if (i % n === 1) {
      textAlign(CENTER);
    }
    if (i % n === 2) {
      textAlign(RIGHT);
    }
    x = i % n * w / 2;
    y = d * Math.floor(i / n);
    if (i >= 6) {
      y += 7.8 * d;
    }
    if (i === 0 || i === 1 || i === 2) {
      fc(1);
    } else {
      fc(0.5);
    }
    text(t, x, d + y);
  }
  return textAlign(LEFT);
};
//# sourceMappingURL=drawP.js.map
