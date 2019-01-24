"use strict";

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

// Generated by CoffeeScript 2.3.2
var LetterButton, LetterPage;

LetterPage = function (_Page) {
  _inherits(LetterPage, _Page);

  function LetterPage() {
    _classCallCheck(this, LetterPage);

    return _possibleConstructorReturn(this, (LetterPage.__proto__ || Object.getPrototypeOf(LetterPage)).apply(this, arguments));
  }

  _createClass(LetterPage, [{
    key: "render",
    value: function render() {
      return this.bg(0);
    }
  }, {
    key: "makeLetters",
    value: function makeLetters(rlk, button, partikod, personer) {
      var _this2 = this;

      var N, h, i, key, letters, n, ref, results, title, w, words, x, y;
      N = 16;
      h = this.h / (N + 1);
      w = this.w / 2;
      this.selected = button;
      this.buttons = [];
      i = 0;
      words = function () {
        var j, len, results;
        results = [];
        for (j = 0, len = personer.length; j < len; j++) {
          key = personer[j];
          results.push(dbPersoner[rlk][key][2]);
        }
        return results;
      }();
      ref = gruppera(words, N + N);
      results = [];
      for (letters in ref) {
        n = ref[letters];
        x = this.x + w * Math.floor(i / N);
        y = this.y + h * (1 + i % N);
        title = letters.length === 1 ? letters : letters[0] + "-" + _.last(letters);
        (function (letters, title) {
          return _this2.addButton(new LetterButton(title, x, y, w - 2, h - 2, n, function () {
            this.page.selected = this;
            return pages.personer.clickLetterButton(rlk, this, partikod, letters, personer);
          }));
        })(letters, title);
        results.push(i++);
      }
      return results;
    }
  }]);

  return LetterPage;
}(Page);

LetterButton = function (_Button) {
  _inherits(LetterButton, _Button);

  function LetterButton(title, x, y, w, h, antal, click) {
    _classCallCheck(this, LetterButton);

    var _this3 = _possibleConstructorReturn(this, (LetterButton.__proto__ || Object.getPrototypeOf(LetterButton)).call(this, title, x, y, w, h, click));

    _this3.antal = antal;
    _this3.pageNo = -1;
    _this3.pages = 1 + Math.floor(_this3.antal / PERSONS_PER_PAGE);
    if (_this3.antal % PERSONS_PER_PAGE === 0) {
      _this3.pages--;
    }
    return _this3;
  }

  _createClass(LetterButton, [{
    key: "draw",
    value: function draw() {
      fc(0.5);
      rect(this.x, this.y, this.w, this.h);
      textSize(0.8 * this.ts);
      textAlign(CENTER, CENTER);
      if (this.page.selected === this) {
        fc(1, 1, 0);
      } else {
        fc(1);
      }
      text(this.title, this.x + this.w / 2, this.y + this.h / 2);
      push();
      this.pageIndicator();
      return pop();
    }
  }, {
    key: "pageIndicator",
    value: function pageIndicator() {
      var dx, i, j, len, ref, results;
      if (this.pages <= 1) {
        return;
      }
      dx = Math.floor(this.w / (this.pages + 1));
      ref = range(this.pages);
      results = [];
      for (j = 0, len = ref.length; j < len; j++) {
        i = ref[j];
        if (i === this.pageNo && this.page.selected === this) {
          fc(1);
        } else {
          fc(0);
        }
        results.push(circle(this.x + (i + 1) * dx, this.y + 0.85 * this.h, 3));
      }
      return results;
    }
  }]);

  return LetterButton;
}(Button);
//# sourceMappingURL=LetterPage.js.map
