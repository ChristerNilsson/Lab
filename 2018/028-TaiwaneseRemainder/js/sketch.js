"use strict";

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.0.3
var BLACK,
    Button,
    Clock,
    GREEN,
    N,
    RED,
    WHITE,
    buttons,
    clocks,
    draw,
    game,
    info,
    mousePressed,
    newGame,
    newGame1,
    ok,
    okidoki,
    reset,
    setup,
    indexOf = [].indexOf,
    modulo = function modulo(a, b) {
  return (+a % (b = +b) + b) % b;
};

buttons = [];

clocks = [];

game = {
  steps: 1
};

N = 60;

RED = "#F00";

GREEN = "#0F0";

BLACK = "#000";

WHITE = "#FFF";

reset = function reset() {
  var clock, k, len, results;
  game.totalSteps = 0;
  game.totalPoints = 0;
  results = [];
  for (k = 0, len = clocks.length; k < len; k++) {
    clock = clocks[k];
    results.push(clock.reset());
  }
  return results;
};

ok = function ok() {
  if (this.enabled) {
    if (game.steps === game.totalSteps && game.totalPoints === game.total) {
      newGame(1);
    }
    if (game.steps === game.totalSteps) {
      return newGame(1);
    } else {
      return newGame(-1);
    }
  }
};

setup = function setup() {
  var params, r;
  createCanvas(1200, 560);
  angleMode(DEGREES);
  textAlign(CENTER, CENTER);
  buttons.push(new Button('Steps:', 120, 60, 48));
  buttons.push(new Button('reset', 120, 170, 48, reset));
  buttons.push(new Button('ok', 120, 280, 48, ok));
  buttons.push(new Button('All clocks green', 120, 380, 24));
  buttons.push(new Button('Use all steps', 120, 410, 24));
  buttons.push(new Button('Share via clipboard', 120, 500, 24, function () {
    copyToClipboard(game.url);
    return this.enabled = false;
  }));
  buttons.push(new Button('Taiwanese Remainder', 120, 20, 20));
  buttons[5].enabled = true;
  if (indexOf.call(window.location.href, '?') >= 0) {
    params = getParameters();
    if (3 === _.size(params)) {
      game = {
        steps: parseInt(params.steps),
        ticks: function () {
          var k, len, ref, results;
          ref = params.ticks.split(',');
          results = [];
          for (k = 0, len = ref.length; k < len; k++) {
            r = ref[k];
            results.push(parseInt(r));
          }
          return results;
        }(),
        rests: function () {
          var k, len, ref, results;
          ref = params.rests.split(',');
          results = [];
          for (k = 0, len = ref.length; k < len; k++) {
            r = ref[k];
            results.push(parseInt(r));
          }
          return results;
        }(),
        url: window.location.href
      };
      newGame1();
      return;
    }
  }
  return newGame(0);
};

Button = function () {
  function Button(txt, x, y, size) {
    var f = arguments.length > 4 && arguments[4] !== undefined ? arguments[4] : function () {};

    _classCallCheck(this, Button);

    this.txt = txt;
    this.x = x;
    this.y = y;
    this.size = size;
    this.f = f;
    this.enabled = false;
  }

  _createClass(Button, [{
    key: "draw",
    value: function draw() {
      fill(this.enabled ? WHITE : BLACK);
      sc();
      textSize(this.size);
      return text(this.txt, this.x, this.y);
    }
  }]);

  return Button;
}();

Clock = function () {
  function Clock(rest, tick1, x, y) {
    _classCallCheck(this, Clock);

    this.rest = rest;
    this.tick = tick1;
    this.x = x;
    this.y = y;
    this.reset();
  }

  _createClass(Clock, [{
    key: "reset",
    value: function reset() {
      this.count = 0;
      this.value = modulo(-this.rest, this.tick);
      this.oldValue = this.value;
      this.delta = 0;
      return this.n = N;
    }
  }, {
    key: "draw",
    value: function draw() {
      var j, k, len, ref, twelve;
      push();
      translate(this.x, this.y);
      sw(4);
      twelve = game.totalPoints % this.tick === this.rest;
      fill(twelve ? GREEN : RED);
      stroke(BLACK);
      circle(0, 0, 50);
      fill(twelve ? BLACK : WHITE);
      sw(1);
      sc();
      textAlign(CENTER, CENTER);
      textSize(40);
      text(this.tick, 0, 0);
      if (this.tick > 30) {
        textSize(20);
        text(this.rest, 0, 30);
      }
      // subtract
      if (this.count > 0) {
        fill(this.count > 0 ? WHITE : BLACK);
        sc();
        textSize(40);
        text(this.count, 80, 0);
      }
      if (this.n < N) {
        this.n++;
      }
      rotate(-90 + this.n / N * this.delta * 360 / this.tick);
      stroke(WHITE);
      ref = range(this.tick);
      for (k = 0, len = ref.length; k < len; k++) {
        j = ref[k];
        sw(2);
        point(50, 0);
        sw(2);
        if (j === this.oldValue) {
          line(25, 0, 46, 0);
        }
        rotate(360 / this.tick);
      }
      return pop();
    }
  }, {
    key: "add",
    value: function add(delta) {
      this.delta = delta;
      this.oldValue = this.value;
      this.value = modulo(this.value + delta, this.tick);
      return this.n = 0;
    }
  }, {
    key: "move",
    value: function move(step) {
      var clock, k, len, results, tick;
      if (this.count + step < 0) {
        return;
      }
      buttons[5].enabled = true;
      tick = step * this.tick;
      game.totalPoints += tick;
      game.totalSteps += step;
      this.count += step;
      results = [];
      for (k = 0, len = clocks.length; k < len; k++) {
        clock = clocks[k];
        results.push(clock.add(tick));
      }
      return results;
    }
  }]);

  return Clock;
}();

okidoki = function okidoki() {
  var clock, k, len;
  if (game.totalSteps !== game.steps) {
    return false;
  }
  for (k = 0, len = clocks.length; k < len; k++) {
    clock = clocks[k];
    if (game.totalPoints % clock.tick !== clock.rest) {
      return false;
    }
  }
  return true;
};

newGame = function newGame(delta) {
  game.steps += delta;
  if (game.steps < 1) {
    game.steps = 1;
  }
  N = int(map(game.steps, 1, 100, 60, 20));
  game = createProblem(game.steps);
  return newGame1();
};

newGame1 = function newGame1() {
  var C, clock, i, k, len, ref, results;
  print(game.steps + ", [" + game.ticks + "], [" + game.rests + "]");
  reset();
  clocks = [];
  C = 5;
  ref = range(game.ticks.length);
  results = [];
  for (k = 0, len = ref.length; k < len; k++) {
    i = ref[k];
    clock = new Clock(game.rests[i], game.ticks[i], 300 + 200 * Math.floor(i / C), 60 + 110 * (i % C));
    clocks.push(clock);
    clock.forward = function () {
      return this.move(1);
    };
    results.push(clock.backward = function () {
      return this.move(-1);
    });
  }
  return results;
};

info = function info() {
  var button, k, len, results;
  buttons[0].txt = 'steps: ' + (game.steps - game.totalSteps);
  buttons[1].enabled = game.totalSteps > 0;
  buttons[2].enabled = okidoki();
  results = [];
  for (k = 0, len = buttons.length; k < len; k++) {
    button = buttons[k];
    results.push(button.draw());
  }
  return results;
};

draw = function draw() {
  var clock, k, len, results;
  bg(0.5);
  info();
  results = [];
  for (k = 0, len = clocks.length; k < len; k++) {
    clock = clocks[k];
    results.push(clock.draw());
  }
  return results;
};

mousePressed = function mousePressed() {
  var b, c, k, l, len, len1, results;
  for (k = 0, len = buttons.length; k < len; k++) {
    b = buttons[k];
    if (50 > dist(mouseX, mouseY, b.x, b.y)) {
      b.f();
    }
  }
  results = [];
  for (l = 0, len1 = clocks.length; l < len1; l++) {
    c = clocks[l];
    if (50 > dist(mouseX, mouseY, c.x, c.y)) {
      c.forward();
    }
    if (50 > dist(mouseX, mouseY, c.x + 100, c.y)) {
      results.push(c.backward());
    } else {
      results.push(void 0);
    }
  }
  return results;
};
//# sourceMappingURL=sketch.js.map
