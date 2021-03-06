"use strict";

// Generated by CoffeeScript 2.3.2
var Page;

Page = class Page {
  constructor(x, y, w, h, cols = 1) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.cols = cols;
    this.selected = null; // anger vilken knapp man klickat på
    this.buttons = [];
    this.modal = false; // spärra underliggande fönster
  }

  inside() {
    return this.x < mouseX && mouseX < this.x + this.w && this.y < mouseY && mouseY < this.y + this.h;
  }

  clear() {
    this.selected = null;
    return this.buttons = [];
  }

  addButton(button) {
    button.page = this;
    return this.buttons.push(button);
  }

  render() {}

  bg() {
    // klarar ett eller tre argument
    fc.apply(null, arguments);
    return rect(this.x, this.y, this.w, this.h);
  }

  draw() {
    var button, i, len, ref, results;
    this.render();
    ref = this.buttons;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      button = ref[i];
      results.push(button.draw());
    }
    return results;
  }

  mousePressed() {
    var button, i, len, ref;
    if (!this.inside()) {
      return false;
    }
    ref = this.buttons;
    for (i = 0, len = ref.length; i < len; i++) {
      button = ref[i];
      if (button.inside()) {
        button.click();
        return true;
      }
    }
    return false;
  }

};
//# sourceMappingURL=Page.js.map
