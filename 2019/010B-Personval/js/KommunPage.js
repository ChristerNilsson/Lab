"use strict";

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

// Generated by CoffeeScript 2.3.2
var KommunPage;

KommunPage = function () {
  var COLS, N;

  var KommunPage = function (_Page) {
    _inherits(KommunPage, _Page);

    function KommunPage(x, y, w, h) {
      _classCallCheck(this, KommunPage);

      var _this = _possibleConstructorReturn(this, (KommunPage.__proto__ || Object.getPrototypeOf(KommunPage)).call(this, x, y, w, h));

      _this.active = true;
      _this.grupper = gruppera(_.values(dbKommun), N * COLS);
      _this.init();
      return _this;
    }

    _createClass(KommunPage, [{
      key: "init",
      value: function init() {
        var _this2 = this;

        var index = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : 0;

        var first, h, i, j, k, key, keys, last, len, len1, letters, namn, ref, ref1, w, x, y;
        this.buttons = [];
        w = this.w / COLS;
        h = this.h / (N + 1);
        keys = _.keys(dbKommun);
        keys.sort(function (a, b) {
          if (dbKommun[a] < dbKommun[b]) {
            return -1;
          } else {
            return 1;
          }
        });
        ref = _.keys(this.grupper);
        for (i = j = 0, len = ref.length; j < len; i = ++j) {
          key = ref[i];
          first = key[0];
          last = _.last(key);
          if (i === index) {
            letters = "" + first + last;
          }
          (function (i) {
            return _this2.addButton(new Button(first + "-" + last, _this2.x + i * w, _this2.y, w - 1, h - 1, function () {
              return this.page.init(i);
            }));
          })(i);
        }
        i = 0;
        for (k = 0, len1 = keys.length; k < len1; k++) {
          key = keys[k];
          namn = dbKommun[key];
          if (letters[0] <= (ref1 = namn[0]) && ref1 <= letters[1]) {
            x = Math.floor(i % (COLS * N) / N) * w;
            y = (1 + i % N) * h;
            this.addButton(new KommunButton(key, this.x + x, this.y + y, w - 1, h - 1, function () {
              rensa();
              return fetchKommun(this.key);
            }));
            i++;
          }
        }
        return this.selected = this.buttons[index];
      }
    }, {
      key: "render",
      value: function render() {}
    }]);

    return KommunPage;
  }(Page);

  ;

  N = 16;

  COLS = 10;

  return KommunPage;
}.call(undefined);
//# sourceMappingURL=KommunPage.js.map
