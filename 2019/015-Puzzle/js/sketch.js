'use strict';

// Generated by CoffeeScript 2.3.2
var Button,
    N,
    buttons,
    current,
    draw,
    goState,
    goalReached,
    grid,
    level,
    mousePressed,
    originalGrid,
    randomMoveList,
    setup,
    state,
    transfer,
    update,
    windowResized,
    modulo = function (a, b) {
  return (+a % (b = +b) + b) % b;
};

N = 100;

buttons = [];

grid = null;

originalGrid = null;

current = 0;

level = 1;

state = 0; // 0=Go 1=Solve 2=Go/Prev/Next

Button = class Button {
  constructor(title, x1, y1, w, h, textSize1, click) {
    this.title = title;
    this.x = x1;
    this.y = y1;
    this.w = w;
    this.h = h;
    this.textSize = textSize1;
    this.click = click;
    this.active = true;
  }

  draw() {
    textAlign(CENTER, CENTER);
    textSize(this.textSize);
    if (this.title === 0) {
      fill(0);
    } else if (this.title === 'Go' && this.active) {
      fill(0, 255, 0);
    } else {
      fill(255);
    }
    rect(N * this.x, N * this.y, this.w, this.h);
    if (this.active) {
      fill(0);
    } else {
      fill(128);
    }
    if (this.title !== 0) {
      return text(this.title, N * this.x + this.w / 2, N * this.y + this.h / 2);
    }
  }

  inside() {
    var x, y;

    //(width-4*N)/2,(height-5*N)/2
    x = mouseX - (width - 4 * N) / 2;
    y = mouseY - (height - 5 * N) / 2;
    return this.active && N * this.x < x && x < N * this.x + this.w && N * this.y < y && y < N * this.y + this.h;
  }

};

randomMoveList = function (grid, nMoves, moveList = []) {
  var last, ldc, ldr, nextGrid, sourceDirection, validMoves;
  if (moveList.length === nMoves) {
    return moveList;
  }
  validMoves = grid.validMoves();
  if (moveList.length > 0) {
    // Don't just revert the last move
    last = _.last(moveList);
    [ldr, ldc] = directionToDelta(last);
    validMoves = _.filter(validMoves, function (m) {
      return !directionsAreOpposites(last, m);
    });
  }
  sourceDirection = _.shuffle(validMoves)[0];
  nextGrid = grid.applyMoveFrom(sourceDirection);
  moveList.push(sourceDirection);
  return randomMoveList(nextGrid, nMoves, moveList);
};

transfer = function () {
  var i, j, len, ref, results;
  ref = range(16);
  results = [];
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    results.push(buttons[i].title = grid.grid[Math.floor(i / 4)][modulo(i, 4)]);
  }
  return results;
};

update = function (delta) {
  current = constrain(current + delta, 0, window.solution.length);
  grid = originalGrid.applyMoves(window.solution.slice(0, current));
  return transfer();
};

goalReached = function () {
  return grid.isSolved();
};

goState = function (newState) {
  var button, i, j, len, ref, results, values;
  state = newState;
  values = "1000 0100 1011".split(' ');
  ref = buttons.slice(16, 20);
  results = [];
  for (i = j = 0, len = ref.length; j < len; i = ++j) {
    button = ref[i];
    results.push(button.active = values[state][i] === '1');
  }
  return results;
};

windowResized = function () {
  return resizeCanvas(windowWidth, windowHeight);
};

setup = function () {
  var i, j, len, ref, x, y;
  createCanvas(windowWidth, windowHeight);
  ref = range(16);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    x = i % 4;
    y = Math.floor(i / 4);
    buttons.push(new Button(i, x, y, N, N, 60, function () {
      var dx, dy, k, len1, move, other, ref1, x0, y0;
      [y0, x0] = grid.emptyPos;
      ref1 = grid.validMoves();
      for (k = 0, len1 = ref1.length; k < len1; k++) {
        move = ref1[k];
        dx = x0 - this.x;
        dy = y0 - this.y;
        if (abs(dx) + abs(dy) === 1) {
          if (move === grid.positionToMove(this.y, this.x)) {
            grid = grid.applyMoveFrom(move);
            other = buttons[x0 + 4 * y0];
            [other.title, this.title] = [this.title, other.title];
          }
        }
      }
      if (goalReached()) {
        goState(0);
        return level++;
      }
    }));
  }
  buttons.push(new Button('Go', 0, 5, N, N / 2, 30, function () {
    goState(1);
    window.solution = [];
    grid = grid.applyMoves(randomMoveList(grid, level));
    return transfer();
  }));
  buttons.push(new Button('Solve', 1, 5, N, N / 2, 30, function () {
    if (level > 1) {
      level--;
    }
    window.solution = [];
    originalGrid = grid.copy();
    solve(grid);
    return goState(2);
  }));
  buttons.push(new Button('Prev', 2, 5, N, N / 2, 30, function () {
    return update(-1);
  }));
  buttons.push(new Button('Next', 3, 5, N, N / 2, 30, function () {
    return update(+1);
  }));
  goState(0);
  grid = new Grid(INIT_GRID, [3, 3]);
  return transfer();
};

draw = function () {
  var button, j, len;
  translate((width - 4 * N) / 2, (height - 5 * N) / 2);
  background(128);
  for (j = 0, len = buttons.length; j < len; j++) {
    button = buttons[j];
    button.draw();
  }
  if (solution.length > 0) {
    textAlign(CENTER, CENTER);
    fill(255);
    text(`${current} of ${solution.length}`, 3 * N, 4.5 * N);
  }
  fill(255);
  return text(level, N, 4.5 * N);
};

mousePressed = function () {
  var button, i, j, len, results;
  results = [];
  for (i = j = 0, len = buttons.length; j < len; i = ++j) {
    button = buttons[i];
    if (button.inside()) {
      if (state === 1 && i < 16 || i >= 16) {
        results.push(button.click());
      } else {
        results.push(void 0);
      }
    } else {
      results.push(void 0);
    }
  }
  return results;
};
//# sourceMappingURL=sketch.js.map
