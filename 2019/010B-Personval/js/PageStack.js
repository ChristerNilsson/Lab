"use strict";

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.3.2
var PageStack;

PageStack = function () {
  function PageStack() {
    _classCallCheck(this, PageStack);

    this.stack = [];
  }

  _createClass(PageStack, [{
    key: "push",
    value: function push(page) {
      return this.stack.push(page);
    }
  }, {
    key: "pop",
    value: function pop() {
      return this.stack.pop();
    }
  }, {
    key: "last",
    value: function last() {
      return _.last(this.stack);
    }
  }, {
    key: "draw",
    value: function draw() {
      var i, last, len, page, ref, results;
      last = this.last();
      ref = this.stack;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        page = ref[i];
        if (last.modal && page === last) {
          fc(0, 0, 0, 0.5);
          rect(0, 0, width, height);
        }
        results.push(page.draw());
      }
      return results;
    }

    // Denna konstruktion nödvändig eftersom klick på Motala ger Utskrift.
    // Dvs ett klick tolkas som två. 

  }, {
    key: "mousePressed",
    value: function mousePressed() {
      var i, last, len, page, ps;
      last = this.last();
      if (last.modal) {
        if (last.mousePressed()) {}
      } else {
        ps = function () {
          var i, len, ref, results;
          ref = this.stack;
          results = [];
          for (i = 0, len = ref.length; i < len; i++) {
            page = ref[i];
            results.push(page);
          }
          return results;
        }.call(this);
        for (i = 0, len = ps.length; i < len; i++) {
          page = ps[i];
          if (page.mousePressed()) {
            return;
          }
        }
      }
    }
  }]);

  return PageStack;
}();
//# sourceMappingURL=PageStack.js.map
