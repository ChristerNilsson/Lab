'use strict';

// Generated by CoffeeScript 2.0.3
var counter, draw, messages, mousePressed, mouseReleased, released, setup;

counter = 0;

messages = [];

released = true;

setup = function setup() {
  return createCanvas(windowWidth, windowHeight);
};

draw = function draw() {
  var i, j, len, message, results;
  bg(1);
  textSize(50);
  results = [];
  for (i = j = 0, len = messages.length; j < len; i = ++j) {
    message = messages[i];
    results.push(text(message, 100, 50 * (i + 1)));
  }
  return results;
};

//mouseTouched = -> messages.push 'mouseTouched'
mouseReleased = function mouseReleased() {
  released = true;
  messages.push('mouseReleased');
  return false;
};

mousePressed = function mousePressed() {
  if (!released) {
    return false;
  }
  released = false;
  counter += 1;
  messages.push('mousePressed ' + counter);
  return false;
};
//# sourceMappingURL=sketch.js.map
