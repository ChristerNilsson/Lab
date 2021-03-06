// Generated by CoffeeScript 2.3.2
var Node;

Node = class Node {
  constructor(parent, play1, board) {
    var i, len, play, ref;
    this.parent = parent;
    this.play = play1;
    this.board = board;
    antal++;
    this.t = 0; // number of wins
    this.n = 0; // number of games
    this.children = {}; // of Nodes
    ref = range(N);
    for (i = 0, len = ref.length; i < len; i++) {
      play = ref[i];
      if (this.board.board[play].length < M) {
        this.children[play] = null;
      }
    }
  }

  expand(play) {
    var childBoard, childNode;
    childBoard = this.board.nextBoard(play);
    childNode = new Node(this, play, childBoard);
    this.children[play] = childNode;
    return childNode;
  }

  allPlays() {
    var child, play, ref, results;
    ref = this.children;
    results = [];
    for (play in ref) {
      child = ref[play];
      results.push(parseInt(play));
    }
    return results;
  }

  unexpandedPlays() {
    var child, play, ref, results;
    ref = this.children;
    results = [];
    for (play in ref) {
      child = ref[play];
      if (child === null) {
        results.push(parseInt(play));
      }
    }
    return results;
  }

  getUCB1() {
    return this.t / this.n + Math.sqrt(UCB * Math.log(this.parent.n) / this.n);
  }

  isFullyExpanded() {
    var child, key, ref;
    ref = this.children;
    for (key in ref) {
      child = ref[key];
      if (child === null) {
        return false;
      }
    }
    return true;
  }

};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibm9kZS5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxub2RlLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQTs7QUFBTSxPQUFOLE1BQUEsS0FBQTtFQUNDLFdBQWMsT0FBQSxPQUFBLE9BQUEsQ0FBQTtBQUNiLFFBQUEsQ0FBQSxFQUFBLEdBQUEsRUFBQSxJQUFBLEVBQUE7SUFEYyxJQUFDLENBQUE7SUFBUSxJQUFDLENBQUE7SUFBTSxJQUFDLENBQUE7SUFDL0IsS0FBQTtJQUNBLElBQUMsQ0FBQSxDQUFELEdBQUssRUFETDtJQUVBLElBQUMsQ0FBQSxDQUFELEdBQUssRUFGTDtJQUdBLElBQUMsQ0FBQSxRQUFELEdBQVksQ0FBQSxFQUhaO0FBSUE7SUFBQSxLQUFBLHFDQUFBOztNQUNDLElBQUcsSUFBQyxDQUFBLEtBQUssQ0FBQyxLQUFNLENBQUEsSUFBQSxDQUFLLENBQUMsTUFBbkIsR0FBNEIsQ0FBL0I7UUFDQyxJQUFDLENBQUEsUUFBUyxDQUFBLElBQUEsQ0FBVixHQUFrQixLQURuQjs7SUFERDtFQUxhOztFQVNkLE1BQVMsQ0FBQyxJQUFELENBQUE7QUFDUixRQUFBLFVBQUEsRUFBQTtJQUFBLFVBQUEsR0FBYSxJQUFDLENBQUEsS0FBSyxDQUFDLFNBQVAsQ0FBaUIsSUFBakI7SUFDYixTQUFBLEdBQVksSUFBSSxJQUFKLENBQVMsSUFBVCxFQUFZLElBQVosRUFBa0IsVUFBbEI7SUFDWixJQUFDLENBQUEsUUFBUyxDQUFBLElBQUEsQ0FBVixHQUFrQjtXQUNsQjtFQUpROztFQU1ULFFBQVcsQ0FBQSxDQUFBO0FBQUcsUUFBQSxLQUFBLEVBQUEsSUFBQSxFQUFBLEdBQUEsRUFBQTtBQUFlO0FBQUE7SUFBQSxLQUFBLFdBQUE7O21CQUFkLFFBQUEsQ0FBUyxJQUFUO0lBQWMsQ0FBQTs7RUFBbEI7O0VBQ1gsZUFBa0IsQ0FBQSxDQUFBO0FBQUcsUUFBQSxLQUFBLEVBQUEsSUFBQSxFQUFBLEdBQUEsRUFBQTtBQUFlO0FBQUE7SUFBQSxLQUFBLFdBQUE7O1VBQWlDLEtBQUEsS0FBUztxQkFBeEQsUUFBQSxDQUFTLElBQVQ7O0lBQWMsQ0FBQTs7RUFBbEI7O0VBQ2xCLE9BQVUsQ0FBQSxDQUFBO1dBQUcsSUFBQyxDQUFBLENBQUQsR0FBSyxJQUFDLENBQUEsQ0FBTixHQUFVLElBQUksQ0FBQyxJQUFMLENBQVUsR0FBQSxHQUFNLElBQUksQ0FBQyxHQUFMLENBQVMsSUFBQyxDQUFBLE1BQU0sQ0FBQyxDQUFqQixDQUFOLEdBQTRCLElBQUMsQ0FBQSxDQUF2QztFQUFiOztFQUVWLGVBQWtCLENBQUEsQ0FBQTtBQUNqQixRQUFBLEtBQUEsRUFBQSxHQUFBLEVBQUE7QUFBQTtJQUFBLEtBQUEsVUFBQTs7TUFDQyxJQUFHLEtBQUEsS0FBUyxJQUFaO0FBQXNCLGVBQU8sTUFBN0I7O0lBREQ7V0FFQTtFQUhpQjs7QUFwQm5CIiwic291cmNlc0NvbnRlbnQiOlsiY2xhc3MgTm9kZSBcclxuXHRjb25zdHJ1Y3RvciA6IChAcGFyZW50LCBAcGxheSwgQGJvYXJkKSAtPlxyXG5cdFx0YW50YWwrK1xyXG5cdFx0QHQgPSAwICMgbnVtYmVyIG9mIHdpbnNcclxuXHRcdEBuID0gMCAjIG51bWJlciBvZiBnYW1lc1xyXG5cdFx0QGNoaWxkcmVuID0ge30gIyBvZiBOb2Rlc1xyXG5cdFx0Zm9yIHBsYXkgaW4gcmFuZ2UgTlxyXG5cdFx0XHRpZiBAYm9hcmQuYm9hcmRbcGxheV0ubGVuZ3RoIDwgTVxyXG5cdFx0XHRcdEBjaGlsZHJlbltwbGF5XSA9IG51bGxcclxuXHJcblx0ZXhwYW5kIDogKHBsYXkpIC0+XHJcblx0XHRjaGlsZEJvYXJkID0gQGJvYXJkLm5leHRCb2FyZCBwbGF5XHJcblx0XHRjaGlsZE5vZGUgPSBuZXcgTm9kZSBALCBwbGF5LCBjaGlsZEJvYXJkXHJcblx0XHRAY2hpbGRyZW5bcGxheV0gPSBjaGlsZE5vZGVcclxuXHRcdGNoaWxkTm9kZVxyXG5cclxuXHRhbGxQbGF5cyA6IC0+IChwYXJzZUludCBwbGF5IGZvciBwbGF5LGNoaWxkIG9mIEBjaGlsZHJlbilcclxuXHR1bmV4cGFuZGVkUGxheXMgOiAtPiAocGFyc2VJbnQgcGxheSBmb3IgcGxheSxjaGlsZCBvZiBAY2hpbGRyZW4gd2hlbiBjaGlsZCA9PSBudWxsKVxyXG5cdGdldFVDQjEgOiAtPiBAdCAvIEBuICsgTWF0aC5zcXJ0KFVDQiAqIE1hdGgubG9nKEBwYXJlbnQubikgLyBAbilcclxuXHJcblx0aXNGdWxseUV4cGFuZGVkIDogLT5cclxuXHRcdGZvciBrZXksY2hpbGQgb2YgQGNoaWxkcmVuIFxyXG5cdFx0XHRpZiBjaGlsZCA9PSBudWxsIHRoZW4gcmV0dXJuIGZhbHNlXHJcblx0XHR0cnVlXHJcbiJdfQ==
//# sourceURL=C:\Lab\2018\090-Connect4-MCTS\coffee\node.coffee