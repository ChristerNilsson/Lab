'use strict';

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

// Generated by CoffeeScript 2.0.3
var KEY, enter, goto, op0, op1, op2, page, setup, stack;

KEY = "007";

stack = [];

page = null;

enter = null;

goto = function goto(p) {
  storeData(KEY, stack);
  return p.display();
};

op0 = function op0(f) {
  f();
  return goto(page);
};

op1 = function op1(f) {
  stack.push(f(stack.pop()));
  return goto(page);
};

op2 = function op2(f) {
  var x, y;
  x = stack.pop();
  y = stack.pop();
  stack.push(f(y, x));
  return goto(page);
};

setup = function setup() {
  stack = fetchData(KEY);
  page = new Page(10, function () {
    var _this = this;

    var i, item, len;
    for (i = 0, len = stack.length; i < len; i++) {
      item = stack[i];
      this.addRow(makeDiv(item));
    }
    this.addRow(enter = makeInput({
      title: 'enter'
    }, function () {
      return _this.action('Enter');
    }));
    return enter.focus();
  });
  page.addAction('Enter', function () {
    return op0(function () {
      return stack.push(parseFloat(enter.value));
    });
  });
  page.addAction('+', function () {
    return op2(function (y, x) {
      return y + x;
    });
  });
  page.addAction('-', function () {
    return op2(function (y, x) {
      return y - x;
    });
  });
  page.addAction('*', function () {
    return op2(function (y, x) {
      return y * x;
    });
  });
  page.addAction('/', function () {
    return op2(function (y, x) {
      return y / x;
    });
  });
  page.addAction('%', function () {
    return op2(function (y, x) {
      return y % x;
    });
  });
  page.addAction('clr', function () {
    return op0(function () {
      return stack = [];
    });
  });
  page.addAction('chs', function () {
    return op1(function (x) {
      return -x;
    });
  });
  page.addAction('1/x', function () {
    return op1(function (x) {
      return 1 / x;
    });
  });
  page.addAction('drp', function () {
    return op0(function () {
      return stack.pop();
    });
  });
  page.addAction('swp', function () {
    return op0(function () {
      var a, b;

      var _stack$splice = stack.splice(-2, 2);

      var _stack$splice2 = _slicedToArray(_stack$splice, 2);

      a = _stack$splice2[0];
      b = _stack$splice2[1];

      return stack = stack.concat([b, a]);
    });
  });
  page.addAction('sin', function () {
    return op1(function (x) {
      return sin(x);
    });
  });
  page.addAction('pi', function () {
    return op0(function () {
      return stack.push(PI);
    });
  });
  return goto(page);
};
//# sourceMappingURL=sketch.js.map
