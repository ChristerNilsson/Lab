"use strict";

// Generated by CoffeeScript 2.0.3
var draw, mousePressed, setup;

setup = function setup() {
  return createCanvas(400, 400);
};

draw = function draw() {
  return bg(1, 0, 1);
};

mousePressed = function mousePressed() {
  //window.location.href = "sms:+46707496800&body=message" # iOS ok!
  return window.location.href = "sms:+46707496800?&body=message";
};
//# sourceMappingURL=sketch.js.map
