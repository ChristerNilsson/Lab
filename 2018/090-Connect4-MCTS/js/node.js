"use strict";

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.3.2
var Node;

Node = function () {
  function Node(parent, play1, board) {
    _classCallCheck(this, Node);

    var i, len, play, ref;
    this.parent = parent;
    this.play = play1;
    this.board = board;
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

  _createClass(Node, [{
    key: "expand",
    value: function expand(play) {
      var childBoard, childNode;
      childBoard = this.board.nextBoard(play);
      childNode = new Node(this, play, childBoard);
      this.children[play] = childNode;
      return childNode;
    }
  }, {
    key: "allPlays",
    value: function allPlays() {
      var child, play, ref, results;
      ref = this.children;
      results = [];
      for (play in ref) {
        child = ref[play];
        results.push(parseInt(play));
      }
      return results;
    }
  }, {
    key: "unexpandedPlays",
    value: function unexpandedPlays() {
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

    //isLeaf : -> false
    // antal = 0
    // for child in @children 
    // 	if child == null then antal++
    // antal == @children.length

  }, {
    key: "isFullyExpanded",
    value: function isFullyExpanded() {
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
  }, {
    key: "getUCB1",
    value: function getUCB1() {
      return this.t / this.n + Math.sqrt(2 * Math.log(this.parent.n) / this.n);
    }
  }]);

  return Node;
}();

//##### tester ######

// b = new Board '333333'
// n = new Node null,null,b,[0,1,2,4,5,6]
// assert n.parent, null
// assert n.play, null
// assert n.board.board.length, N
// assert n.children, {0:null, 1:null, 2:null, 4:null, 5:null, 6:null}

// assert n.isLeaf(), false
// child = n.expand 2
// print n
// assert child.board.board[2], 'X'
// assert child.board.board[3], 'XOXOXO'
// assert child.n, 0
// assert child.parent, n
// assert child.play, 2
// assert child.t, 0
// assert n.isLeaf(), false
// assert child.isLeaf(), false
// assert n.allPlays(),[0, 1, 2, 4, 5, 6]
// assert n.unexpandedPlays(),[0, 1, 4, 5, 6]
// assert n.isFullyExpanded(),false
// for play in n.unexpandedPlays()
// 	n.expand parseInt play 
// assert n.unexpandedPlays(),[]
// assert n.isFullyExpanded(),true 

// child.t = 1
// child.n = 2
// grandChild = child.expand 4
// assert grandChild.isLeaf(), false 
// grandChild.t = 1
// grandChild.n = 2
// assert 1.3325546111576978, grandChild.getUCB1()
//# sourceMappingURL=node.js.map
