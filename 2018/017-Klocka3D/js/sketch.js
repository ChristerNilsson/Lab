"use strict";

// Generated by CoffeeScript 2.0.3
var draw, pushPop, r, rotation, setup, urtavla, visare;

rotation = 0; // grader. Ett varv på 12 sekunder.

r = null;

setup = function setup() {
  createCanvas(windowWidth, windowHeight, WEBGL);
  return r = 0.01 * 0.5 * min(width, height);
};

pushPop = function pushPop(f) {
  push();
  f();
  return pop();
};

urtavla = function urtavla() {
  var i, j, len, ref, results;
  torus(70 * r, 3 * r, 48, 32);
  ref = range(12);
  results = [];
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    pushPop(function () {
      translate(0, 64 * r);
      return box(6 * r, 9 * r, 6 * r);
    });
    results.push(rotateZ(radians(30)));
  }
  return results;
};

visare = function visare(tid, antal, motvikt, längd, bredd, z) {
  return pushPop(function () {
    rotateZ(radians(map(tid, 0, antal, 180, 540)));
    translate(0, 0.5 * längd - motvikt, z);
    return box(bredd, längd + motvikt, 4);
  });
};

draw = function draw() {
  normalMaterial();
  bg(0);
  rotateY(radians(rotation));
  rotation -= 0.5; // 360/(60*12)
  urtavla();
  visare(second(), 60, 8 * r, 60 * r, 3 * r, r);
  visare(minute(), 60, 8 * r, 60 * r, 6 * r, 0);
  return visare(hour() + minute() / 60.0, 12, 6 * r, 48 * r, 6 * r, -r);
};
//# sourceMappingURL=sketch.js.map
