"use strict";

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.0.3
var Node, f, _findHead, nodes;

nodes = null;

Node = function () {
  function Node(head, size, edges) {
    _classCallCheck(this, Node);

    this.head = head;
    this.size = size;
    this.edges = edges;
  }

  _createClass(Node, [{
    key: "update",
    value: function update(other) {
      this.size += other.size;
      return this.edges += other.edges + 1;
    }
  }]);

  return Node;
}();

f = function f(n, lst) {
  var a, b, i, j, k, len, len1, node;
  nodes = function () {
    var j, len, ref, results;
    ref = range(n);
    results = [];
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      results.push(new Node(i, 1, 0));
    }
    return results;
  }();
  for (j = 0, len = lst.length; j < len; j++) {
    var _lst$j = _slicedToArray(lst[j], 2);

    a = _lst$j[0];
    b = _lst$j[1];

    a = _findHead(a);
    b = _findHead(b);
    if (a !== b) {
      nodes[a].head = b;
      nodes[b].update(nodes[a]);
    } else {
      nodes[a].edges++;
    }
  }
  for (i = k = 0, len1 = nodes.length; k < len1; i = ++k) {
    node = nodes[i];
    if (node.head === i && node.size * (node.size - 1) !== 2 * node.edges) {
      return false;
    }
  }
  return true;
};

_findHead = function findHead(u) {
  if (u === nodes[u].head) {
    return u;
  } else {
    return _findHead(nodes[u].head);
  }
};

assert(true, f(4, [[0, 2], [0, 3], [2, 3 // zero based
]]));

print(nodes);

assert(false, f(4, [[2, 0], [1, 2], [2, 3], [0, 1]]));

print(nodes);
//# sourceMappingURL=sketch.js.map
