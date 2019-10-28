class Game {
  constructor(level) {
    this.init = this.init.bind(this);
    this.action = this.action.bind(this);
    this.init(level);
  }

  init(level) {
    this.level = level;
    if (this.level < 2) {
      this.level = 2;
    }
    this.low = 1;
    this.high = 2 ** this.level - 1;
    this.secret = this.low + Math.floor((this.high-this.low) * Math.random());
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

//export default Game 

module.exports = Game;
