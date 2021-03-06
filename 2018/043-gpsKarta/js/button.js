'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.3.2
var Button;

Button = function () {
  function Button(prompt, x, y) {
    var click = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : function () {};

    _classCallCheck(this, Button);

    this.prompt = prompt;
    this.x = x;
    this.y = y;
    this.click = click;
    this.radius = 100;
  }

  _createClass(Button, [{
    key: 'contains',
    value: function contains(mx, my) {
      return this.radius > dist(mx, my, this.x, this.y);
    }
  }, {
    key: 'draw',
    value: function draw() {
      var n, ts;
      sw(2);
      sc(0);
      fc(1, 1, 0, 0.5);
      if (this.prompt === '') {
        fc();
      }
      circle(this.x, this.y, this.radius);
      textAlign(CENTER, CENTER);
      fc(0);
      sc();
      n = str(this.prompt).length;
      if (n > 5) {
        n = 5;
      }
      ts = [0, 200, 150, 100, 75, 50][n];
      textSize(ts);
      return text(this.prompt, this.x, this.y + ts * 0.07);
    }
  }]);

  return Button;
}();
//# sourceMappingURL=button.js.map
