'use strict';

// Generated by CoffeeScript 2.0.3
var canvas, draw, h, mode, setup, w;

canvas = null;

mode = 'P';

w = null;

h = null;

setup = function setup() {
  var readDeviceOrientation;

  //c = document.createElement 'canvas'
  //context = c.getContext '2d'
  //document.body.appendChild c
  //devicePixelRatio = window.devicePixelRatio || 1
  //backingStoreRatio = context.webkitBackingStorePixelRatio || context.mozBackingStorePixelRatio || context.msBackingStorePixelRatio || context.oBackingStorePixelRatio || context.backingStorePixelRatio || 1
  //ratio = devicePixelRatio / backingStoreRatio
  w = window.innerWidth;
  h = window.innerHeight;
  //c.width = w * ratio
  //c.height = h * ratio
  //c.style.width = w + 'px'
  //c.style.height = h + 'px'
  canvas = createCanvas(w, h);
  //canvas.parent = c
  readDeviceOrientation = function readDeviceOrientation() {
    var ref;
    h = window.innerWidth;
    w = window.innerHeight;
    if ((ref = window.orientation) === -90 || ref === 90) {
      noCanvas();
      createCanvas(h / 2, w / 2);
      textAlign(CENTER, CENTER);
      textSize(20);
      return mode = 'L';
    } else {
      noCanvas();
      createCanvas(h / 2, w / 2);
      textAlign(CENTER, CENTER);
      textSize(20);
      return mode = 'P';
    }
  };
  window.onorientationchange = readDeviceOrientation;
  return readDeviceOrientation();
};

draw = function draw() {
  bg(0.5);
  text(window.devicePixelRatio, width / 2, 0.10 * height);
  text(window.innerWidth + ' ' + window.innerHeight, width / 2, 0.20 * height);
  text(mode + ' ' + width + ' ' + height, width / 2, 0.30 * height);
  text(screen.width + ' ' + screen.height, width / 2, 0.40 * height);
  if (window.orientation) {
    return text(window.orientation, width / 2, 0.50 * height);
  }
};
//# sourceMappingURL=sketch.js.map
