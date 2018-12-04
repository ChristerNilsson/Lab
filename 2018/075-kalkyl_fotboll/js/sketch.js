"use strict";

// Generated by CoffeeScript 2.0.3
var draw,
    f,
    highscore,
    images,
    preload,
    s,
    setup,
    timer,
    modulo = function modulo(a, b) {
  return (+a % (b = +b) + b) % b;
};

s = null;

f = null;

highscore = 0;

timer = 2000;

images = [];

preload = function preload() {
  images.push(loadImage("plan.jpg"));
  images.push(loadImage("fotboll.png"));
  images.push(loadImage("kalkyl.png"));
  return images.push(loadImage("kalkyl_vinst.png"));
};

setup = function setup() {
  createCanvas(images[0].width, images[0].height);
  textAlign(CENTER, CENTER);
  s = {
    x: 200,
    y: height / 2
  };
  f = {
    x: width / 2,
    y: height / 2
  };
  return textSize(100);
};

draw = function draw() {
  bg(0);
  fc(1, 1, 0, 0.25);
  image(images[0], 0, 0);
  text("Tid kvar: " + timer, width / 2, 100);
  text("Antal fotbollar: " + highscore, width / 2, height - 100);
  image(images[1], f.x - 25, f.y - 30, 50, 50);
  image(images[2], s.x - 70, s.y - 80, 100, 100);
  if (keyIsDown(UP_ARROW)) {
    s.y = modulo(s.y - 5, height);
  }
  if (keyIsDown(DOWN_ARROW)) {
    s.y = modulo(s.y + 5, height);
  }
  if (keyIsDown(LEFT_ARROW)) {
    s.x = modulo(s.x - 5, width);
  }
  if (keyIsDown(RIGHT_ARROW)) {
    s.x = modulo(s.x + 5, width);
  }
  timer--;
  if (50 > dist(s.x, s.y, f.x, f.y)) {
    f = {
      x: random(50, width - 50),
      y: random(50, height - 50)
    };
    highscore += 1;
  }
  if (timer === 0) {
    noLoop();
    bg(0);
    image(images[3], 0, 50);
    fc(1);
    return text(highscore, 100, 100);
  }
};
//# sourceMappingURL=sketch.js.map
