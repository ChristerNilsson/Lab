'use strict';

// Generated by CoffeeScript 2.3.2
var Button, DONE, HIDDEN, N, VISIBLE, alfabet, buttons, done, draw, mousePressed, newGame, setup, test, visible;

N = 6;

HIDDEN = 0;

VISIBLE = 1;

DONE = 2;

done = 0;

buttons = [];

alfabet = 'AABBCC';

visible = [];

Button = class Button {
  constructor(title, x1, y1) {
    this.title = title;
    this.x = x1;
    this.y = y1;
    this.state = HIDDEN;
    this.w = 50;
    this.h = 50;
  }

  inside(x, y) {
    return this.x - this.w / 2 < x && x < this.x + this.w / 2 && this.y - this.h / 2 < y && y < this.y + this.h / 2;
  }

  draw() {
    if (this.state !== DONE) {
      rect(this.x, this.y, this.w, this.h);
    }
    if (this.state === VISIBLE) {
      return text(this.title, this.x, this.y);
    }
  }

  click() {
    var a, b, j, len;
    if (this.state !== HIDDEN) {
      return;
    }
    this.state = VISIBLE;
    switch (visible.length) {
      case 0:
        return visible.push(this);
      case 1:
        a = this;
        b = visible[0];
        if (a.title === b.title) {
          a.state = DONE;
          b.state = DONE;
          done += 2;
          visible = [];
          if (done === N) {
            return newGame();
          }
        } else {
          return visible.push(this);
        }
        break;
      case 2:
        for (j = 0, len = visible.length; j < len; j++) {
          b = visible[j];
          b.state = HIDDEN;
        }
        return visible = [this];
    }
  }

};

setup = function () {
  createCanvas(600, 600);
  test();
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(42);
  return newGame();
};

newGame = function () {
  var i, j, len, letter, ref, results;
  alfabet = _.shuffle(alfabet);
  buttons = [];
  done = 0;
  ref = range(N);
  results = [];
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    letter = alfabet[i];
    results.push(buttons.push(new Button(letter, 100 + 50 * i, 100)));
  }
  return results;
};

draw = function () {
  var button, j, len, results;
  bg(0.5);
  results = [];
  for (j = 0, len = buttons.length; j < len; j++) {
    button = buttons[j];
    results.push(button.draw());
  }
  return results;
};

mousePressed = function () {
  var button, j, len, results;
  results = [];
  for (j = 0, len = buttons.length; j < len; j++) {
    button = buttons[j];
    if (button.inside(mouseX, mouseY)) {
      results.push(button.click());
    } else {
      results.push(void 0);
    }
  }
  return results;
};

test = function () {
  var a, b, c, d, e, f;
  a = new Button('A', 0, 0);
  b = new Button('A', 0, 0);
  c = new Button('B', 0, 0);
  d = new Button('B', 0, 0);
  e = new Button('C', 0, 0);
  f = new Button('C', 0, 0);
  visible = [];
  // ______ startläge
  assert('A', a.title);
  assert(HIDDEN, a.state);
  assert(0, visible.length);
  a.click(); // A_____
  assert(VISIBLE, a.state);
  assert(1, visible.length);
  assert('A', visible[0].title);
  assert(VISIBLE, visible[0].state);
  a.click(); // A_____ Klick på redan synlig, inget ska hända
  assert(VISIBLE, a.state);
  assert(1, visible.length);
  assert('A', visible[0].title);
  assert(VISIBLE, visible[0].state);
  b.click(); //   ____ AA klickat
  assert(DONE, a.state);
  assert(DONE, b.state);
  assert(0, visible.length);
  c.click(); //   B___
  e.click(); //   B_C_ BC klickat
  assert(VISIBLE, c.state);
  assert(VISIBLE, e.state);
  assert(2, visible.length);
  assert('B', visible[0].title);
  assert('C', visible[1].title);
  d.click(); //   _B__
  assert(HIDDEN, c.state);
  assert(VISIBLE, d.state);
  assert(HIDDEN, e.state);
  assert(1, visible.length);
  assert('B', visible[0].title);
  c.click(); //     __
  assert(DONE, c.state);
  assert(DONE, d.state);
  assert(0, visible.length);
  e.click(); //     C_
  assert(VISIBLE, e.state);
  assert(1, visible.length);
  assert('C', visible[0].title);
  f.click();
  assert(DONE, e.state);
  assert(DONE, f.state);
  assert(0, visible.length);
  return print('Ready!');
};
//# sourceMappingURL=sketch.js.map
