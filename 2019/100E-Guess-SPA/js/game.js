// Generated by CoffeeScript 2.4.1
var Game;

Game = class Game {
  constructor(level) {
    this.init = this.init.bind(this);
    this.action = this.action.bind(this);
    this.init(level);
  }

  init(level1) {
    this.level = level1;
    if (this.level < 2) {
      this.level = 2;
    }
    this.low = 1;
    this.high = 2 ** this.level - 1;
    this.secret = _.random(this.low, this.high);
    return this.hist = [];
  }

  action(value) {
    value = parseInt(value);
    this.hist.push(value);
    if (value < this.secret && value >= this.low) {
      this.low = value + 1;
    }
    if (value > this.secret && value <= this.high) {
      this.high = value - 1;
    }
    if (value === this.secret) {
      return this.init(this.level + (this.hist.length <= this.level ? 1 : -1));
    }
  }

};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZ2FtZS5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxnYW1lLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQTs7QUFBTSxPQUFOLE1BQUEsS0FBQTtFQUNDLFdBQWMsQ0FBQyxLQUFELENBQUE7UUFFZCxDQUFBLFdBQUEsQ0FBQTtRQU9BLENBQUEsYUFBQSxDQUFBO0lBVHlCLElBQUMsQ0FBQSxJQUFELENBQU0sS0FBTjtFQUFYOztFQUVkLElBQU8sT0FBQSxDQUFBO0lBQUMsSUFBQyxDQUFBO0lBQ1IsSUFBRyxJQUFDLENBQUEsS0FBRCxHQUFTLENBQVo7TUFBbUIsSUFBQyxDQUFBLEtBQUQsR0FBUyxFQUE1Qjs7SUFDQSxJQUFDLENBQUEsR0FBRCxHQUFPO0lBQ1AsSUFBQyxDQUFBLElBQUQsR0FBUSxDQUFBLElBQUcsSUFBQyxDQUFBLEtBQUosR0FBWTtJQUNwQixJQUFDLENBQUEsTUFBRCxHQUFVLENBQUMsQ0FBQyxNQUFGLENBQVMsSUFBQyxDQUFBLEdBQVYsRUFBZSxJQUFDLENBQUEsSUFBaEI7V0FDVixJQUFDLENBQUEsSUFBRCxHQUFRO0VBTEY7O0VBT1AsTUFBUyxDQUFDLEtBQUQsQ0FBQTtJQUNSLEtBQUEsR0FBUSxRQUFBLENBQVMsS0FBVDtJQUNSLElBQUMsQ0FBQSxJQUFJLENBQUMsSUFBTixDQUFXLEtBQVg7SUFDQSxJQUFHLEtBQUEsR0FBUSxJQUFDLENBQUEsTUFBVCxJQUFvQixLQUFBLElBQVMsSUFBQyxDQUFBLEdBQWpDO01BQTBDLElBQUMsQ0FBQSxHQUFELEdBQU8sS0FBQSxHQUFRLEVBQXpEOztJQUNBLElBQUcsS0FBQSxHQUFRLElBQUMsQ0FBQSxNQUFULElBQW9CLEtBQUEsSUFBUyxJQUFDLENBQUEsSUFBakM7TUFBMkMsSUFBQyxDQUFBLElBQUQsR0FBUSxLQUFBLEdBQVEsRUFBM0Q7O0lBQ0EsSUFBRyxLQUFBLEtBQVMsSUFBQyxDQUFBLE1BQWI7YUFDQyxJQUFDLENBQUEsSUFBRCxDQUFNLElBQUMsQ0FBQSxLQUFELEdBQVMsQ0FBRyxJQUFDLENBQUEsSUFBSSxDQUFDLE1BQU4sSUFBZ0IsSUFBQyxDQUFBLEtBQXBCLEdBQStCLENBQS9CLEdBQXNDLENBQUMsQ0FBdkMsQ0FBZixFQUREOztFQUxROztBQVZWIiwic291cmNlc0NvbnRlbnQiOlsiY2xhc3MgR2FtZSAgXHJcblx0Y29uc3RydWN0b3IgOiAobGV2ZWwpIC0+IEBpbml0IGxldmVsXHJcblxyXG5cdGluaXQgOiAoQGxldmVsKSA9PlxyXG5cdFx0aWYgQGxldmVsIDwgMiB0aGVuIEBsZXZlbCA9IDJcclxuXHRcdEBsb3cgPSAxXHJcblx0XHRAaGlnaCA9IDIqKkBsZXZlbCAtIDFcclxuXHRcdEBzZWNyZXQgPSBfLnJhbmRvbSBAbG93LCBAaGlnaFxyXG5cdFx0QGhpc3QgPSBbXVxyXG5cdFxyXG5cdGFjdGlvbiA6ICh2YWx1ZSkgPT5cclxuXHRcdHZhbHVlID0gcGFyc2VJbnQgdmFsdWVcclxuXHRcdEBoaXN0LnB1c2ggdmFsdWVcclxuXHRcdGlmIHZhbHVlIDwgQHNlY3JldCBhbmQgdmFsdWUgPj0gQGxvdyB0aGVuIEBsb3cgPSB2YWx1ZSArIDFcclxuXHRcdGlmIHZhbHVlID4gQHNlY3JldCBhbmQgdmFsdWUgPD0gQGhpZ2ggdGhlbiBAaGlnaCA9IHZhbHVlIC0gMVxyXG5cdFx0aWYgdmFsdWUgPT0gQHNlY3JldCBcclxuXHRcdFx0QGluaXQgQGxldmVsICsgaWYgQGhpc3QubGVuZ3RoIDw9IEBsZXZlbCB0aGVuIDEgZWxzZSAtMVxyXG5cclxuIl19
//# sourceURL=c:\Lab\2019\100E-Guess-SPA\coffee\game.coffee