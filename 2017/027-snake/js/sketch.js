"use strict";

// Generated by CoffeeScript 2.0.3
var draw, food, keyPressed, kvadrat, n, pickLocation, setup, side, snake;

snake = null;

side = 20;

n = 30;

food = null;

kvadrat = function kvadrat(pos, color) {
  fill(color);
  return rect(side * pos.x, side * pos.y, side, side);
};

setup = function setup() {
  createCanvas(600, 600);
  snake = new Snake();
  frameRate(10);
  return pickLocation();
};

pickLocation = function pickLocation() {
  return food = createVector(floor(random(0, n)), floor(random(0, n)));
};

draw = function draw() {
  background(51);
  if (snake.eat(food)) {
    pickLocation();
  }
  snake.death();
  snake.update();
  snake.show();
  return kvadrat(food, color(255, 0, 100));
};

keyPressed = function keyPressed() {
  if (keyCode === RIGHT_ARROW) {
    snake.dir = [1, 2, 3, 0][snake.dir];
  }
  if (keyCode === LEFT_ARROW) {
    return snake.dir = [3, 0, 1, 2][snake.dir];
  }
};
//# sourceMappingURL=sketch.js.map
