'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.0.3
var Button, FREE, N, O, WINNERS, X, ai, buttons, draw, four, investigate, makeWINNERS, message, mousePressed, newGame, sel, setup;

Button = function () {
  function Button(x1, y1, title, execute) {
    _classCallCheck(this, Button);

    this.x = x1;
    this.y = y1;
    this.title = title;
    this.execute = execute;
    this.w = 95;
  }

  _createClass(Button, [{
    key: 'draw',
    value: function draw() {
      rect(this.x, this.y, this.w, this.w);
      return text(this.title, this.x, this.y);
    }
  }, {
    key: 'inside',
    value: function inside(mx, my) {
      return this.x - this.w / 2 < mx && mx < this.x + this.w / 2 && this.y - this.w / 2 < my && my < this.y + this.w / 2;
    }
  }]);

  return Button;
}();

N = 4;

FREE = ' ';
X = 'X';
O = 'O';


WINNERS = [];

buttons = [];

message = '';

makeWINNERS = function makeWINNERS() {
  var arr, ch, k, len, quad, results;
  arr = 'abcd efgh ijkl mnop aeim bfjn cgko dhlp afkp dgjm'.split(' ');
  results = [];
  for (k = 0, len = arr.length; k < len; k++) {
    quad = arr[k];
    results.push(WINNERS.push(function () {
      var l, len1, results1;
      results1 = [];
      for (l = 0, len1 = quad.length; l < len1; l++) {
        ch = quad[l];
        results1.push('abcdefghijklmnop'.indexOf(ch));
      }
      return results1;
    }()));
  }
  return results;
};

setup = function setup() {
  var i, j, k, len, ref, results, x, y;
  createCanvas(500, 500);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(100);
  makeWINNERS();
  ref = range(N);
  results = [];
  for (k = 0, len = ref.length; k < len; k++) {
    i = ref[k];
    results.push(function () {
      var l, len1, ref1, results1;
      ref1 = range(N);
      results1 = [];
      for (l = 0, len1 = ref1.length; l < len1; l++) {
        j = ref1[l];
        x = 100 + 100 * i;
        y = 100 + 100 * j;

        results1.push(buttons.push(new Button(x, y, FREE, function () {
          if (message !== '') {
            return newGame();
          }
          if (this.title !== FREE) {
            return;
          }
          this.title = O;
          if (four(sel(O))) {
            return message = 'human wins!';
          }
          ai();
          if (four(sel(X))) {
            message = 'computer wins!';
          }
          if (sel(FREE).length === 0) {
            return message = 'remi!';
          }
        })));
      }
      return results1;
    }());
  }
  return results;
};

newGame = function newGame() {
  var button, k, len;
  for (k = 0, len = buttons.length; k < len; k++) {
    button = buttons[k];
    button.title = FREE;
  }
  return message = '';
};

sel = function sel(m) {
  var b, i, k, len, results;
  results = [];
  for (i = k = 0, len = buttons.length; k < len; i = ++k) {
    b = buttons[i];
    if (b.title === m) {
      results.push(i);
    }
  }
  return results;
};

investigate = function investigate(marker) {
  var i, k, len, markers, ref;
  markers = sel(marker);
  ref = sel(FREE);
  for (k = 0, len = ref.length; k < len; k++) {
    i = ref[k];
    if (four(markers.concat(i))) {
      buttons[i].title = X;
      return true;
    }
  }
  return false;
};

ai = function ai() {
  // computer is X
  var index;
  if (investigate(X)) {
    // try winning
    return;
  }
  if (investigate(O)) {
    // avoid losing
    return;
  }
  index = _.sample(sel(FREE)); // random move
  return buttons[index].title = X;
};

four = function four(b) {
  var k, len, winner;
  for (k = 0, len = WINNERS.length; k < len; k++) {
    winner = WINNERS[k];
    if (_.intersection(winner, b).length === N) {
      return true;
    }
  }
  return false;
};

draw = function draw() {
  var button, k, len;
  bg(0.5);
  for (k = 0, len = buttons.length; k < len; k++) {
    button = buttons[k];
    button.draw();
  }
  push();
  textSize(50);
  fc(1, 0, 0);
  text(message, width / 2, height / 2);
  return pop();
};

mousePressed = function mousePressed() {
  var button, k, len, results;
  results = [];
  for (k = 0, len = buttons.length; k < len; k++) {
    button = buttons[k];
    if (button.inside(mouseX, mouseY)) {
      results.push(button.execute());
    } else {
      results.push(void 0);
    }
  }
  return results;
};
//# sourceMappingURL=sketch.js.map