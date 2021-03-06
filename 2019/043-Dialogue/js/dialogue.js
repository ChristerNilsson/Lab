'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.3.2
var Button, Dialogue, RectButton, dialogues;

dialogues = [];

Dialogue = function () {
  function Dialogue(number, x1, y1, textSize1) {
    _classCallCheck(this, Dialogue);

    this.number = number;
    this.x = x1;
    this.y = y1;
    this.textSize = textSize1;
    this.col = '#ff08';
    this.buttons = [];
    dialogues.push(this);
  }

  _createClass(Dialogue, [{
    key: 'add',
    value: function add(button) {
      button.dlg = this;
      return this.buttons.push(button);
    }
  }, {
    key: 'clock',
    value: function clock(title, n, r1, r2) {
      var backPop = arguments.length > 4 && arguments[4] !== undefined ? arguments[4] : true;
      var turn = arguments.length > 5 && arguments[5] !== undefined ? arguments[5] : 0;

      var i, j, len, ref, v;
      this.backPop = backPop;
      ref = range(n);
      for (j = 0, len = ref.length; j < len; j++) {
        i = ref[j];
        v = i * 360 / n - turn;
        this.add(new Button('', r1 * cos(v), r1 * sin(v), r2, function () {}));
      }
      return this.add(new Button(title, 0, 0, r2, function () {
        if (this.dlg.backPop) {
          return dialogues.pop();
        } else {
          return dialogues.clear();
        }
      }));
    }
  }, {
    key: 'update',
    value: function update(delta) {
      // -1 eller +1
      var i, j, len, ref, ref1, results;
      if (0 <= (ref = this.pageStart + delta * this.pageSize) && ref < this.lst.length) {
        this.pageStart += delta * this.pageSize;
        ref1 = range(this.pageSize);
        results = [];
        for (j = 0, len = ref1.length; j < len; j++) {
          i = ref1[j];
          if (this.pageStart + i < this.lst.length) {
            results.push(this.buttons[i].arr = this.lst[this.pageStart + i]);
          } else {
            results.push(this.buttons[i].arr = []);
          }
        }
        return results;
      }
    }
  }, {
    key: 'list',
    value: function list(lst) {
      var pageSize = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 10;

      var _this = this;

      var backPop = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : true;
      var click = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : function (arr) {
        return print(arr[0]);
      };

      var h, i, item, j, len, n, ref, w, x, y;
      this.lst = lst;
      this.pageSize = pageSize;
      this.backPop = backPop;
      this.pageStart = 0;
      n = this.pageSize;
      x = 0;
      w = width;
      h = height / (this.pageSize + 1);
      this.buttons.clear();
      ref = range(this.pageStart, this.pageStart + n);
      for (j = 0, len = ref.length; j < len; j++) {
        i = ref[j];
        if (i < this.lst.length) {
          item = this.lst[i];
          y = i * h;
          (function (item) {
            return _this.add(new RectButton(item, x, y, w, h, function () {
              return click(this.arr);
            }));
          })(item);
        }
      }
      this.add(new RectButton([-1, 'Prev'], 0 * w / 3, h * n, w / 3, h, function () {
        return this.dlg.update(-1);
      }));
      this.add(new RectButton([-1, 'Cancel'], 1 * w / 3, h * n, w / 3, h, function () {
        if (this.dlg.backPop) {
          return dialogues.pop();
        } else {
          return dialogues.clear();
        }
      }));
      return this.add(new RectButton([-1, 'Next'], 2 * w / 3, h * n, w / 3, h, function () {
        return this.dlg.update(+1);
      }));
    }
  }, {
    key: 'show',
    value: function show() {
      var button, j, len, ref;
      push();
      translate(this.x, this.y);
      textSize(this.textSize);
      ref = this.buttons;
      for (j = 0, len = ref.length; j < len; j++) {
        button = ref[j];
        button.show(this);
      }
      return pop();
    }
  }, {
    key: 'execute',
    value: function execute(mx, my) {
      var button, j, len, ref;
      ref = this.buttons;
      for (j = 0, len = ref.length; j < len; j++) {
        button = ref[j];
        if (button.inside(mx, my, this)) {
          button.execute();
          return true;
        }
      }
      return false;
    }
  }]);

  return Dialogue;
}();

Button = function () {
  function Button(txt, x1, y1, r) {
    var event = arguments.length > 4 && arguments[4] !== undefined ? arguments[4] : function () {
      return print(this.txt);
    };

    _classCallCheck(this, Button);

    this.txt = txt;
    this.x = x1;
    this.y = y1;
    this.r = r;
    this.event = event;
    this.active = true;
  }

  _createClass(Button, [{
    key: 'info',
    value: function info(txt, active, event) {
      this.txt = txt;
      this.active = active;
      this.event = event;
    }
  }, {
    key: 'show',
    value: function show() {
      var arr;
      if (this.active) {
        fill(this.dlg.col);
      } else {
        fill("#fff8");
      }
      stroke(0);
      ellipse(this.x, this.y, 2 * this.r, 2 * this.r);
      push();
      if (this.active) {
        fill(0);
      } else {
        fill("#888");
      }
      noStroke();
      textAlign(CENTER, CENTER);
      textSize(this.dlg.textSize);
      arr = this.txt.split(' ');
      if (arr.length === 1) {
        text(arr[0], this.x, this.y);
      } else {
        text(arr[0], this.x, this.y - 0.3 * this.r);
        text(arr[1], this.x, this.y + 0.3 * this.r);
      }
      return pop();
    }
  }, {
    key: 'inside',
    value: function inside(mx, my) {
      return this.r > dist(mx, my, this.dlg.x + this.x, this.dlg.y + this.y);
    }
  }, {
    key: 'execute',
    value: function execute() {
      if (this.active) {
        return this.event();
      }
    }
  }]);

  return Button;
}();

RectButton = function () {
  function RectButton(arr1, x1, y1, w1, h1) {
    var event = arguments.length > 5 && arguments[5] !== undefined ? arguments[5] : function () {
      return print(this.item);
    };

    _classCallCheck(this, RectButton);

    this.arr = arr1;
    this.x = x1;
    this.y = y1;
    this.w = w1;
    this.h = h1;
    this.event = event;
    this.active = true;
  }

  _createClass(RectButton, [{
    key: 'info',
    value: function info(arr1, active, event) {
      this.arr = arr1;
      this.active = active;
      this.event = event;
    }
  }, {
    key: 'show',
    value: function show() {
      if (this.active) {
        fill(this.dlg.col);
      } else {
        fill("#fff8");
      }
      stroke(0);
      rect(this.x, this.y, this.w, this.h);
      push();
      if (this.active) {
        fill(0);
      } else {
        fill("#888");
      }
      noStroke();
      textSize(this.dlg.textSize);
      if (this.arr.length === 1 + 1) {
        textAlign(CENTER, CENTER);
        text(this.arr[1], this.x + this.w / 2, this.y + this.h / 2);
      }
      if (this.arr.length === 1 + 2) {
        textAlign(LEFT, CENTER);
        text(this.arr[1], this.x + 10, this.y + this.h / 2);
        textAlign(RIGHT, CENTER);
        text(this.arr[2], this.x + this.w - 10, this.y + this.h / 2);
      }
      if (this.arr.length === 1 + 3) {
        textAlign(LEFT, CENTER);
        text(this.arr[1], this.x + 10, this.y + this.h / 2);
        textAlign(CENTER, CENTER);
        text(this.arr[2], this.x + this.w / 2, this.y + this.h / 2);
        textAlign(RIGHT, CENTER);
        text(this.arr[3], this.x + this.w - 10, this.y + this.h / 2);
      } else {}
      return pop();
    }
  }, {
    key: 'inside',
    value: function inside(mx, my) {
      return this.x < mx && mx < this.x + this.w && this.y < my && my < this.y + this.h;
    }
  }, {
    key: 'execute',
    value: function execute() {
      if (this.active) {
        return this.event();
      }
    }
  }]);

  return RectButton;
}();
//# sourceMappingURL=dialogue.js.map
