'use strict';

// Generated by CoffeeScript 2.3.2
// Denna fil användes istället för sketch.coffee när man ska kalibrera en ny karta
// Klicka på tydliga referenspunkter i de fyra hörnen
// T ex vägskäl, hus, broar, kraftledningar, osv
// Avläs koordinaterna med tangent F12
var img, mousePressed, preload, setup;

img = null;

//preload = -> img = loadImage '2019-SommarN.jpg'
preload = function preload() {
  return img = loadImage('2019-SommarS.jpg');
};

setup = function setup() {
  createCanvas(img.width, img.height);
  image(img, 0, 0, width, height);
  return print(img);
};

mousePressed = function mousePressed() {
  return print(round(mouseX), round(mouseY));
};
//# sourceMappingURL=measure.js.map
