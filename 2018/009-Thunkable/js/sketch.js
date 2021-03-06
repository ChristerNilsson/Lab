'use strict';

// Generated by CoffeeScript 2.0.3
var goto, op, op1, op2, op3, page, panel, setup, state;

panel = ['', '', ''];

page = null;

state = 0;

goto = function goto(p) {
  return p.display();
};

op = function op(key) {
  panel[state] += key;
  return goto(page);
};

op1 = function op1(key) {
  panel[1] = key;
  state = 2;
  return goto(page);
};

op2 = function op2() {
  var operator, res, x, y;
  x = parseInt(panel[0]);
  operator = panel[1];
  y = parseInt(panel[2]);
  if (operator === '+') {
    res = x + y;
  }
  if (operator === '-') {
    res = x - y;
  }
  if (operator === '*') {
    res = x * y;
  }
  if (operator === '/') {
    res = x / y;
  }
  panel = [res, '', ''];
  state = 0;
  return goto(page);
};

op3 = function op3() {
  panel = ['', '', ''];
  state = 0;
  return goto(page);
};

setup = function setup() {
  page = new Page(4, function () {
    return this.addRow(makeDiv(panel[state]));
  });
  page.addAction('1', function () {
    return op('1');
  });
  page.addAction('2', function () {
    return op('2');
  });
  page.addAction('3', function () {
    return op('3');
  });
  page.addAction('+', function () {
    return op1('+');
  });
  page.addAction('4', function () {
    return op('4');
  });
  page.addAction('5', function () {
    return op('5');
  });
  page.addAction('6', function () {
    return op('6');
  });
  page.addAction('-', function () {
    return op1('-');
  });
  page.addAction('7', function () {
    return op('7');
  });
  page.addAction('8', function () {
    return op('8');
  });
  page.addAction('9', function () {
    return op('9');
  });
  page.addAction('*', function () {
    return op1('*');
  });
  page.addAction('C', function () {
    return op3();
  });
  page.addAction('0', function () {
    return op('0');
  });
  page.addAction('=', function () {
    return op2();
  });
  page.addAction('/', function () {
    return op1('/');
  });
  return goto(page);
};
//# sourceMappingURL=sketch.js.map
