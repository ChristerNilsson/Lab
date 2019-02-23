'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.3.2
var Calculator, calculator, draw, execute, setup, txt;

Calculator = function () {
  function Calculator() {
    _classCallCheck(this, Calculator);

    this.stack = [];
  }

  _createClass(Calculator, [{
    key: 'calc',
    value: function calc(opers) {
      var i, len, oper, ref;
      if (opers.length === 0) {
        return '';
      }
      ref = opers.split(' ');
      for (i = 0, len = ref.length; i < len; i++) {
        oper = ref[i];
        switch (oper) {
          case '+':
            this.stack.push(this.stack.pop() + this.stack.pop());
            break;
          case 'p':
            this.stack.push(1 / (1 / this.stack.pop() + 1 / this.stack.pop()));
            break;
          case '':
            break;
          default:
            this.stack.push(parseFloat(oper));
        }
      }
      if (this.stack.length > 0) {
        return this.stack.pop();
      } else {
        return "";
      }
    }
  }]);

  return Calculator;
}();

calculator = new Calculator();

assert(30, calculator.calc('10 20 +'));

assert(15, calculator.calc('30 30 p'));

assert(16.04364406779661, calculator.calc('10 4.7 + 8.9 p 0.5 + 10 +'));

assert(10, calculator.calc('10 2 + 6 p 8 + 6 p 4 + 8 p 4 + 8 p 6 +'));

txt = '10 20 + 30 p';

setup = function setup() {
  createCanvas(891, 45);
  return textSize(40);
};

draw = function draw() {
  bg(0.5);
  return text(calculator.calc(txt), 10, 40);
};

execute = function execute(control) {
  return txt = control.value.trim();
};
//# sourceMappingURL=sketch.js.map
