"use strict";

// Generated by CoffeeScript 2.3.2
var PageStack;

PageStack = class PageStack {
  constructor() {
    this.stack = [];
  }

  push(page) {
    return this.stack.push(page);
  }

  pop() {
    return this.stack.pop();
  }

  last() {
    return _.last(this.stack);
  }

  draw() {
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
  mousePressed() {
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

};
//# sourceMappingURL=PageStack.js.map
