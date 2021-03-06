'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.0.3
// negativt x innebär högerjustering. Characters, not pixels
var Grid, HEIGHT, Line, Text, WIDTH, drawComment, index, keyPressed, mouseWheel, move, objects, setup, xdraw;

WIDTH = 10; // pixels per character

HEIGHT = 23; // pixels per character

objects = [];

index = 0;

setup = function setup() {
  createCanvas(800, 600);
  textSize(20);
  textFont('monospace');
  strokeCap(SQUARE);
  makeCommands();
  index = 1;
  return xdraw();
};

Text = function () {
  function Text(txt, x1, y) {
    var comment1 = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : '';

    _classCallCheck(this, Text);

    // relative characters
    this.txt = txt;
    this.x = x1;
    this.y = y;
    this.comment = comment1;
  }

  _createClass(Text, [{
    key: 'draw',
    value: function draw(i) {
      var p;
      if (i >= index) {
        return;
      }
      if (this.x < 0) {
        textAlign(RIGHT, TOP);
      } else {
        textAlign(LEFT, TOP);
      }
      if (this.index === index) {
        fc(1, 1, 0);
      } else {
        fc(0);
      }
      sc();
      p = this.parent;
      text(this.txt, WIDTH * (p.cx + p.cw * abs(this.x)), HEIGHT * (p.cy + p.ch * this.y));
      if (this.index === index) {
        return drawComment(this.comment);
      }
    }
  }]);

  return Text;
}();

Line = function () {
  function Line(x1, y1, x2, y2, d1) {
    var comment1 = arguments.length > 5 && arguments[5] !== undefined ? arguments[5] : '';

    _classCallCheck(this, Line);

    // absoluta pixlar
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.d = d1;
    this.comment = comment1;
  }

  _createClass(Line, [{
    key: 'draw',
    value: function draw(i) {
      if (i >= index) {
        return;
      }
      sw(this.d);
      if (this.index === index) {
        sc(1, 1, 0);
      } else {
        sc(0);
      }
      line(this.x1, this.y1, this.x2, this.y2);
      if (this.index === index) {
        return drawComment(this.comment);
      }
    }
  }]);

  return Line;
}();

Grid = function () {
  function Grid(cx, cy, cw, ch, xCount, yCount, visible) {
    var comment1 = arguments.length > 7 && arguments[7] !== undefined ? arguments[7] : '';

    _classCallCheck(this, Grid);

    // characters
    this.cx = cx;
    this.cy = cy;
    this.cw = cw;
    this.ch = ch;
    this.xCount = xCount;
    this.yCount = yCount;
    this.visible = visible;
    this.comment = comment1;
    index++;
    this.index = index;
    objects.push(this);
  }

  _createClass(Grid, [{
    key: 'xx',
    value: function xx(i) {
      return WIDTH * (this.cx + this.cw * i + 0.5); // pixlar
    }
  }, {
    key: 'yy',
    value: function yy(j) {
      return HEIGHT * (this.cy + this.ch * j); // pixlar
    }
  }, {
    key: 'add',
    value: function add(obj) {
      index++;
      obj.index = index;
      objects.push(obj);
      return obj.parent = this;
    }
  }, {
    key: 'horLine',
    value: function horLine(j, d) {
      var comment = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : '';

      return this.add(new Line(this.xx(0), this.yy(j), this.xx(this.xCount), this.yy(j), d, comment));
    }
  }, {
    key: 'verLine',
    value: function verLine(i, d) {
      var comment = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : '';

      return this.add(new Line(this.xx(i), this.yy(0), this.xx(i), this.yy(this.yCount), d, comment));
    }
  }, {
    key: 'draw',
    value: function draw(i) {
      var j, k, l, len, len1, ref, ref1;
      if (this.visible && i < index) {
        sw(1);
        sc(0);
        if (this.index === index) {
          sc(1, 1, 0);
        } else {
          sc(0);
        }
        ref = range(this.xCount + 1);
        for (k = 0, len = ref.length; k < len; k++) {
          i = ref[k];
          line(this.xx(i), this.yy(0), this.xx(i), this.yy(this.yCount));
        }
        ref1 = range(this.yCount + 1);
        for (l = 0, len1 = ref1.length; l < len1; l++) {
          j = ref1[l];
          line(this.xx(0), this.yy(j), this.xx(this.xCount), this.yy(j));
        }
      }
      if (this.index === index) {
        return drawComment(this.comment);
      }
    }
  }]);

  return Grid;
}();

drawComment = function drawComment(comment) {
  fc(0);
  sc();
  textAlign(LEFT, BOTTOM);
  text(comment, 10, height - 10);
  textAlign(RIGHT, BOTTOM);
  return text('#' + index, width - 10, height - 10);
};

xdraw = function xdraw() {
  var i, k, len, obj, results;
  bg(0.5);
  results = [];
  for (i = k = 0, len = objects.length; k < len; i = ++k) {
    obj = objects[i];
    results.push(obj.draw(i));
  }
  return results;
};

move = function move(delta) {
  var i, lst;
  lst = indexes.concat([objects.length]);
  if (delta === -1) {
    lst.reverse();
    i = _.findIndex(lst, function (x) {
      return index > x;
    });
    if (i === -1) {
      return;
    }
    return index = lst[i];
  } else {
    i = _.findIndex(lst, function (x) {
      return index < x;
    });
    if (i === -1) {
      return;
    }
    return index = lst[i];
  }
};

keyPressed = function keyPressed() {
  if (keyCode === LEFT_ARROW) {
    index--;
  }
  if (keyCode === RIGHT_ARROW) {
    index++;
  }
  if (keyCode === UP_ARROW || keyCode === 33) {
    move(-1);
  }
  if (keyCode === DOWN_ARROW || keyCode === 34) {
    move(1);
  }
  if (keyCode === 36) {
    index = 1;
  }
  if (keyCode === 35) {
    index = objects.length;
  }
  index = constrain(index, 1, objects.length);
  return xdraw();
};

mouseWheel = function mouseWheel(event) {
  index += event.delta / 100;
  index = constrain(index, 1, objects.length);
  xdraw();
  return false; // blocks page scrolling
};
//# sourceMappingURL=sketch.js.map
