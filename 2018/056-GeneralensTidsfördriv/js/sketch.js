"use strict";

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

// Generated by CoffeeScript 2.0.3
// Vectorized Playing Cards 2.0 - http://sourceforge.net/projects/vector-cards/
// Copyright 2015 - Chris Aguilar - conjurenation@gmail.com
// Licensed under LGPL 3 - www.gnu.org/copyleft/lesser.html

//  4  4  4  4  4  0  8  8  8  8  8
//  5  5  5  5  5  1  9  9  9  9  9
//  6  6  6  6  6  2 10 10 10 10 10
//  7  7  7  7  7  3 11 11 11 11 11
//    12 13 14 15    16 17 18 19      PANEL
var ACES,
    H,
    HEAPS,
    LIMIT,
    LONG,
    N,
    OFFSETX,
    PANEL,
    RANK,
    SUIT,
    W,
    aceCards,
    assert,
    autoShake,
    backs,
    board,
    calcAntal,
    cands,
    cards,
    classic,
    compress,
    countAceCards,
    display,
    dsts,
    expand,
    faces,
    fakeBoard,
    findAllMoves,
    h,
    hash,
    hint,
    hintOne,
    hintsLeft,
    hist,
    keyPressed,
    legalMove,
    makeAutoShake,
    makeBoard,
    makeKey,
    makeMove,
    maxHints,
    mousePressed,
    msg,
    newGame,
    nextLevel,
    originalBoard,
    pack,
    preload,
    prettyCard,
    prettyMove,
    printSolution,
    range,
    restart,
    setup,
    shake,
    showHeap,
    srcs,
    start,
    undoMove,
    unpack,
    w,
    indexOf = [].indexOf;

ACES = [0, 1, 2, 3];

HEAPS = [4, 5, 6, 7, 8, 9, 10, 11];

PANEL = [12, 13, 14, 15, 16, 17, 18, 19];

SUIT = "club heart spade diamond".split(' ');

RANK = "A 2 3 4 5 6 7 8 9 T J Q K".split(' ');

LONG = " Ace 2 3 4 5 6 7 8 9 Ten Jack Queen King".split(' ');

OFFSETX = 468;

W = 263.25;

H = 352;

w = W / 3;

h = H / 3;

LIMIT = 2000; // Maximum steps considered before giving up.

faces = null;

backs = null;

board = null;

cards = null;

hist = null;

cands = null;

hash = null;

aceCards = 4;

originalBoard = null;

start = null;

msg = '';

autoShake = [];

shake = true;

N = null; // Max rank

classic = false;

srcs = null;

dsts = null;

hintsLeft = null;

maxHints = null;

preload = function preload() {
  faces = loadImage('cards/Color_52_Faces_v.2.0.png');
  return backs = loadImage('cards/Playing_Card_Backs.png');
};

range = _.range;

assert = function assert(a, b) {
  var msg = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 'Assert failure';

  return chai.assert.deepEqual(a, b, msg);
};

compress = function compress(board) {
  var h1, h2, heap, i, j, l, len, len1, ref, res, results, suit1, suit2, temp, v1, v2;
  results = [];
  for (j = 0, len = HEAPS.length; j < len; j++) {
    heap = HEAPS[j];
    if (board[heap].length > 1) {
      temp = board[heap][0];
      res = [];
      ref = range(1, board[heap].length);
      for (l = 0, len1 = ref.length; l < len1; l++) {
        i = ref[l];

        var _unpack = unpack(temp);

        var _unpack2 = _slicedToArray(_unpack, 3);

        suit1 = _unpack2[0];
        h1 = _unpack2[1];
        v1 = _unpack2[2];

        var _unpack3 = unpack(board[heap][i]);

        var _unpack4 = _slicedToArray(_unpack3, 3);

        suit2 = _unpack4[0];
        h2 = _unpack4[1];
        v2 = _unpack4[2];

        if (suit1 === suit2 && 1 === abs(v1 - h2)) {
          temp = pack(suit1, h1, v2);
        } else {
          res.push(temp);
          temp = pack(suit2, h2, v2);
        }
      }
      res.push(temp);
      results.push(board[heap] = res);
    } else {
      results.push(void 0);
    }
  }
  return results;
};

// suit är nollbaserad
// rank1 är nollbaserad
// rank2 är nollbaserad
// I talet räknas rank1 och rank2 upp
pack = function pack(suit, rank1) {
  var rank2 = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : rank1;

  if (rank1 === rank2) {
    rank2 = -1;
  }
  return suit + 10 * (rank1 + 1) + 1000 * (rank2 + 1); // rank=1..13 suit=0..3 
};

assert(10, pack(0, 0)); // club A

assert(13, pack(3, 0)); // diamond A

assert(23, pack(3, 1, 1)); // diamond 2

assert(12111, pack(1, 10, 11)); // heart J,Q

assert(111, pack(1, 10, 10)); // heart J,J

unpack = function unpack(n) {
  var rank1, rank2, suit;
  suit = n % 10;
  rank1 = Math.floor(n / 10) % 100;
  rank2 = Math.floor(n / 1000);
  if (rank2 === 0) {
    rank2 = rank1;
  }
  return [suit, rank1 - 1, rank2 - 1];
};

assert([0, 0, 0], unpack(10));

assert([3, 0, 0], unpack(13));

assert([1, 10, 11], unpack(12111));

makeBoard = function makeBoard(maxRank, classic) {
  var card, heap, i, j, l, len, len1, len2, len3, len4, len5, m, o, p, q, rank, ref, ref1, ref2, ref3, suit;
  N = maxRank;
  cards = [];
  ref = range(4);
  for (j = 0, len = ref.length; j < len; j++) {
    suit = ref[j];
    ref1 = range(1, maxRank);
    // 2..K
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      rank = ref1[l];
      cards.push(pack(suit, rank));
    }
  }
  cards = _.shuffle(cards);
  board = [];
  ref2 = range(20);
  for (m = 0, len2 = ref2.length; m < len2; m++) {
    i = ref2[m];
    board.push([]);
  }
  ref3 = range(4);
  for (heap = o = 0, len3 = ref3.length; o < len3; heap = ++o) {
    suit = ref3[heap];
    board[heap].push(pack(suit, 0)); // Ess
  }
  for (p = 0, len4 = PANEL.length; p < len4; p++) {
    heap = PANEL[p];
    board[heap].push(cards.pop());
  }
  for (i = q = 0, len5 = cards.length; q < len5; i = ++q) {
    card = cards[i];
    board[classic ? 4 + i % 8 : int(random(4, 12))].push(card);
  }
  return compress(board);
};

fakeBoard = function fakeBoard() {
  N = 13;
  classic = false;
  if (N === 3) {
    board = [[10], [11], [12], [13], [], [], [], [], [], [], [], [], [21], [33], [23], [31], [30], [22], [32], [20] // 3
    ];
  }
  if (N === 4) {
    board = [[10], [11], [12], [13], [32], [], [21], [], [], [], [41], [42], [33], [23], [31], [20], [43], [22], [30], [40] // 4
    ];
  }
  if (N === 4) {
    board = [[10], [11], [12], [13], [23, 43], [], [], [], [], [], [41], [22], [32], [42], [31], [40], [33], [21], [20], [30]];
  }
  if (N === 5) {
    board = [[10], [11], [12], [13], [21, 30], [43, 20], [], [53], [32], [50, 22], [], [], [41], [51], [31], [42], [23], [52], [40], [33] // 5
    ];
  }
  if (N === 5) {
    board = [[10], [11], [12], [13], [], [3041], [20], [33], [42], [], [53], [4030], [52], [50], [32], [22], [51], [43], [21], [23]];
  }
  if (N === 6) {
    board = [[10], [11], [12], [13], [32, 51, 5060], [62], [31], [], [22], [53], [42, 3023], [52], [43], [30], [20], [61], [21], [41], [63], [40] // 6 
    ];
  }
  if (N === 7) {
    board = [[10], [11], [12], [13], [23, 63], [], [20, 72, 50, 21, 51], [31, 73, 22], [53, 41, 61], [33], [], [6070], [62], [42], [71], [30], [43], [40], [32], [52] // 7
    ];
  }
  if (N === 7) {
    board = [[10], [11], [12], [13], [53, 33], [30, 72], [40, 42], [23, 73], [60, 22, 63], [], [71, 43, 5041], [61], [50], [52], [21], [62], [70], [20], [31], [32]];
  }
  if (N === 8) {
    board = [[10], [11], [12], [13], [62, 20, 50, 43, 31, 70], [51, 60, 2033, 72], [52, 22, 81], [83], [73], [30, 63], [41, 40], [], [80], [42], [53], [71], [32], [21], [82], [61] // 8
    ];
  }
  if (N === 9) {
    board = [[10], [11], [12], [13], [53, 80, 71, 91], [50, 93, 70], [42, 81], [41, 7063, 61], [32, 82, 21], [20, 40], [30, 52, 72], [62, 92, 90], [51], [83], [43], [33], [60], [23], [22], [31] // 9
    ];
  }
  if (N === 10) {
    board = [[10], [11], [12], [13], [93, 90, 41, 20, 83, 23], [53, 62, 103], [100, 43, 61], [], [22, 81, 51, 80, 33], [102, 73, 31], [21, 32, 91, 72], [50, 52, 82, 40], [92], [70], [30], [60], [42], [63], [71], [101] // T
    ];
  }
  if (N === 11) {
    board = [[10], [11], [12], [13], [3042, 53, 93, 33, 103, 82], [3021, 72], [91, 40], [111], [50, 20, 52, 23, 92, 80, 113, 71, 101], [100, 43, 90, 83], [62, 41], [70, 61, 112, 63], [51], [60], [73], [22], [102], [81], [30], [110] // J
    ];
  }
  if (N === 12) {
    board = [[10], [11], [12], [13], [20, 73], [60, 100, 33, 92, 71, 51], [91, 61, 103, 90, 50], [80, 93, 121, 23, 52], [102, 30, 111, 63, 21, 53, 81], [122, 83, 112], [43, 62, 40], [42, 70, 123, 41, 22], [113], [31], [110], [120], [72], [101], [32], [82] // Q
    ];
  }
  if (N === 13) {
    board = [[10], [11], [12], [13], [22, 53, 100, 40, 33], [5061, 102, 131], [5062, 93, 73, 42, 60, 72, 83], [41, 111, 81, 133, 63, 50, 120], [70, 71], [92, 20, 121, 130], [11123, 31, 9080, 23], [101, 82, 91, 43], [32], [132], [112], [122], [21], [103], [110], [30] // K
    ];
  }
  if (N === 13) {
    return board = [[10], [11], [12], [13], [50, 101, 112, 43, 42], [62, 133, 72, 102, 53], [71, 63, 111, 30, 80], [20, 100, 32, 81, 103], [51, 22, 61, 92, 91], [110, 52, 82, 21, 60], [122, 121, 41, 83, 123], [120, 73, 40, 90, 113], [93], [70], [33], [31], [131], [132], [23], [130] // C
    ];
  }
};

makeAutoShake = function makeAutoShake() {
  var i, j, len, ref, results;
  autoShake = [];
  ref = range(52);
  results = [];
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    results.push(autoShake.push([int(random(-2, 2)), int(random(-2, 2))]));
  }
  return results;
};

setup = function setup() {
  createCanvas(800, 600);
  makeAutoShake();
  newGame('3');
  return display(board);
};

showHeap = function showHeap(board, heap, x, y, dx) {
  var card, dr, i, j, k, l, len, len1, n, rank, ref, ref1, suit, unvisible, visible, x0, y0;
  n = calcAntal(board[heap]);
  if (n === 0) {
    return;
  }
  x0 = width / 2 - w / 2;
  if (x < 0) {
    x0 += -w + dx;
  }
  if (x > 0) {
    x0 += w - dx;
  }
  x = x0 + x * dx / 2;
  y = y * h;
  ref = board[heap];
  for (k = j = 0, len = ref.length; j < len; k = ++j) {
    card = ref[k];

    var _unpack5 = unpack(card);

    var _unpack6 = _slicedToArray(_unpack5, 3);

    suit = _unpack6[0];
    unvisible = _unpack6[1];
    visible = _unpack6[2];

    dr = unvisible < visible ? 1 : -1;
    ref1 = range(unvisible, visible + dr, dr);
    for (i = l = 0, len1 = ref1.length; l < len1; i = ++l) {
      rank = ref1[i];

      var _ref = shake ? autoShake[13 * suit + rank] : [0, 0];

      var _ref2 = _slicedToArray(_ref, 2);

      x0 = _ref2[0];
      y0 = _ref2[1];

      image(faces, x0 + x, y0 + y + 13, w, h, OFFSETX + W * rank, 1092 + H * suit, 243, H);
      x += dx;
    }
  }
  card = _.last(board[heap]);

  var _unpack7 = unpack(card);

  var _unpack8 = _slicedToArray(_unpack7, 3);

  suit = _unpack8[0];
  unvisible = _unpack8[1];
  visible = _unpack8[2];

  if (indexOf.call(ACES, heap) >= 0 && visible === N - 1) {
    var _ref3 = shake ? autoShake[13 * suit + rank] : [0, 0];

    var _ref4 = _slicedToArray(_ref3, 2);

    x0 = _ref4[0];
    y0 = _ref4[1];

    return image(backs, x0 + x, y0 + y + 13, w, h, OFFSETX + 860, 1092 + 622, 243, H);
  }
};

display = function display(board) {
  var dx, heap, j, l, len, len1, len2, len3, m, n, o, ref, ref1, results, x, xx, y;
  background(0, 128, 0);
  textAlign(CENTER, CENTER);
  textSize(10);
  x = width / 2 - 5 + 2;
  y = height - 110;
  fill(200);
  text('U = Undo', x, y);
  text('R = Restart', x, y + 10);
  // text '3 4 5 6 = Easy',    x,y+20
  // text '7 8 9 = Medium',    x,y+30
  // text 'T J Q K = Hard',    x,y+40
  text('3 4 5 6 7 8 9 T J Q K', x, y + 20);
  text('Easy    Level    Hard', x, y + 30);
  text('C = Classic', x, y + 40);
  text('Space = Next', x, y + 60);
  text("H = Hint (" + hintsLeft + " left)", x, y + 70);
  text(msg, x, y + 105);
  textSize(24);
  text(classic ? 'Classic' : LONG[N], x, y + 89);
  textAlign(LEFT, CENTER);
  textSize(10);
  text('Generalens Tidsfördriv', 0, height - 5);
  for (y = j = 0, len = ACES.length; j < len; y = ++j) {
    heap = ACES[y];
    showHeap(board, heap, 0, y, 0);
  }
  ref = [4, 5, 6, 7];
  for (y = l = 0, len1 = ref.length; l < len1; y = ++l) {
    heap = ref[y];
    n = calcAntal(board[heap]);
    dx = n <= 7 ? w / 2 : (width / 2 - w / 2 - w) / (n - 1);
    showHeap(board, heap, -2, y, -dx);
  }
  ref1 = [8, 9, 10, 11];
  for (y = m = 0, len2 = ref1.length; m < len2; y = ++m) {
    heap = ref1[y];
    n = calcAntal(board[heap]);
    dx = n <= 7 ? w / 2 : (width / 2 - w / 2 - w) / (n - 1);
    showHeap(board, heap, 2, y, dx);
  }
  results = [];
  for (x = o = 0, len3 = PANEL.length; o < len3; x = ++o) {
    heap = PANEL[x];
    xx = [-8, -6, -4, -2, 2, 4, 6, 8][x];
    results.push(showHeap(board, heap, xx, 4, w));
  }
  return results;
};

legalMove = function legalMove(board, a, b) {
  var a1, a2, b1, b2, sa, sb;
  if (indexOf.call(ACES, a) >= 0) {
    return false;
  }
  if (indexOf.call(PANEL, b) >= 0) {
    return false;
  }
  if (board[a].length === 0) {
    return false;
  }
  if (board[b].length === 0) {
    return true;
  }

  var _unpack9 = unpack(_.last(board[a]));

  var _unpack10 = _slicedToArray(_unpack9, 3);

  sa = _unpack10[0];
  a1 = _unpack10[1];
  a2 = _unpack10[2];

  var _unpack11 = unpack(_.last(board[b]));

  var _unpack12 = _slicedToArray(_unpack11, 3);

  sb = _unpack12[0];
  b1 = _unpack12[1];
  b2 = _unpack12[2];

  if (sa === sb && abs(a2 - b2) === 1) {
    return true;
  }
  return false;
};

makeMove = function makeMove(board, a, b, record) {
  // from heap a to heap b
  var suit, unvisible, visible, xx, yy;

  // reverse order
  var _unpack13 = unpack(board[a].pop());

  var _unpack14 = _slicedToArray(_unpack13, 3);

  suit = _unpack14[0];
  visible = _unpack14[1];
  unvisible = _unpack14[2];
  if (record) {
    hist.push([a, b, 1 + abs(unvisible - visible)]);
  }
  if (board[b].length > 0) {
    var _unpack15 = unpack(board[b].pop());

    var _unpack16 = _slicedToArray(_unpack15, 3);

    xx = _unpack16[0];
    unvisible = _unpack16[1];
    yy = _unpack16[2];
  }
  return board[b].push(pack(suit, unvisible, visible));
};

// returns text move
undoMove = function undoMove(_ref5) {
  var _ref6 = _slicedToArray(_ref5, 3),
      a = _ref6[0],
      b = _ref6[1],
      antal = _ref6[2];

  var suit, unvisible, visible;

  var _unpack17 = unpack(board[b].pop());

  var _unpack18 = _slicedToArray(_unpack17, 3);

  suit = _unpack18[0];
  unvisible = _unpack18[1];
  visible = _unpack18[2];

  if (unvisible < visible) {
    board[a].push(pack(suit, visible, visible - antal + 1));
    if (visible !== unvisible + antal - 1) {
      board[b].push(pack(suit, unvisible, visible - antal));
      return prettyMove(a, b, board);
    }
  } else {
    board[a].push(pack(suit, visible, visible + antal - 1));
    if (unvisible !== visible + antal - 1) {
      board[b].push(pack(suit, unvisible, visible + antal));
      return prettyMove(a, b, board);
    }
  }
};

mousePressed = function mousePressed() {
  var found, heap, holes, j, l, len, len1, marked, mx, my, ref;
  if (!(0 < mouseX && mouseX < width)) {
    return;
  }
  if (!(0 < mouseY && mouseY < height)) {
    return;
  }
  marked = null;
  mx = Math.floor(mouseX / (W / 3));
  my = Math.floor(mouseY / (H / 3));
  if (my >= 4) {
    if (mx <= 3) {
      marked = 12 + mx;
    }
    if (mx >= 5) {
      marked = 11 + mx;
    }
  } else {
    if (mx === 4) {
      marked = my;
    } else if (mx < 4) {
      marked = [4, 5, 6, 7][my];
    } else {
      marked = [8, 9, 10, 11][my];
    }
  }
  if (marked === null) {
    return;
  }
  holes = [];
  found = false;
  ref = ACES.concat(HEAPS);
  for (j = 0, len = ref.length; j < len; j++) {
    heap = ref[j];
    if (board[heap].length === 0) {
      holes.push(heap);
    }
    if (indexOf.call(holes, heap) < 0 && legalMove(board, marked, heap)) {
      makeMove(board, marked, heap, true);
      found = true;
      break;
    }
  }
  if (!found) {
    for (l = 0, len1 = holes.length; l < len1; l++) {
      heap = holes[l];
      if (legalMove(board, marked, heap)) {
        makeMove(board, marked, heap, true);
        break;
      }
    }
  }
  if (4 * N === countAceCards(board)) {
    if (hintsLeft === maxHints) {
      msg = Math.floor((millis() - start) / 1000) + " seconds";
    } else if (hintsLeft === maxHints - 1) {
      msg = "1 hint used";
    } else {
      msg = maxHints - hintsLeft + " hints used";
    }
  }
  return display(board);
};

//###### AI-section ########
findAllMoves = function findAllMoves(b) {
  var dst, j, l, len, len1, res, src;
  srcs = HEAPS.concat(PANEL);
  dsts = ACES.concat(HEAPS);
  res = [];
  for (j = 0, len = srcs.length; j < len; j++) {
    src = srcs[j];
    for (l = 0, len1 = dsts.length; l < len1; l++) {
      dst = dsts[l];
      if (src !== dst) {
        if (legalMove(b, src, dst)) {
          res.push([src, dst]);
        }
      }
    }
  }
  return res;
};

makeKey = function makeKey(b) {
  var card, heap, index, j, l, len, len1, r1, r2, res, suit;
  res = '';
  for (index = j = 0, len = b.length; j < len; index = ++j) {
    heap = b[index];
    if (heap.length === 0) {
      res += '.';
    }
    for (l = 0, len1 = heap.length; l < len1; l++) {
      card = heap[l];

      var _unpack19 = unpack(card);

      var _unpack20 = _slicedToArray(_unpack19, 3);

      suit = _unpack20[0];
      r1 = _unpack20[1];
      r2 = _unpack20[2];

      if (r1 === r2) {
        res += 'chsd'[suit] + RANK[r1];
      } else {
        res += 'chsd'[suit] + RANK[r1] + RANK[r2];
      }
    }
    res += '|';
  }
  return res;
};

calcAntal = function calcAntal(lst) {
  var card, j, len, res, suit, unvisible, visible;
  res = 0;
  for (j = 0, len = lst.length; j < len; j++) {
    card = lst[j];

    var _unpack21 = unpack(card);

    var _unpack22 = _slicedToArray(_unpack21, 3);

    suit = _unpack22[0];
    unvisible = _unpack22[1];
    visible = _unpack22[2];

    res += 1 + abs(unvisible - visible);
  }
  return res;
};

countAceCards = function countAceCards(b) {
  var heap, j, len, res;
  res = 0;
  for (j = 0, len = ACES.length; j < len; j++) {
    heap = ACES[j];
    res += calcAntal(b[heap]);
  }
  return res;
};

expand = function expand(_ref7) {
  var _ref8 = _slicedToArray(_ref7, 4),
      aceCards = _ref8[0],
      level = _ref8[1],
      b = _ref8[2],
      path = _ref8[3];

  var b1, dst, j, key, len, move, moves, newPath, res, src;
  res = [];
  moves = findAllMoves(b);
  for (j = 0, len = moves.length; j < len; j++) {
    move = moves[j];
    var _move = move;

    var _move2 = _slicedToArray(_move, 2);

    src = _move2[0];
    dst = _move2[1];

    b1 = _.cloneDeep(b);
    makeMove(b1, src, dst);
    key = makeKey(b1);
    if (!(key in hash)) {
      newPath = path.concat([move]);
      hash[key] = [newPath, b];
      res.push([countAceCards(b1), level + 1, b1, path.concat([move])]);
    }
  }
  return res;
};

hint = function hint() {
  var card, j, len, res, u, undone;
  if (hintsLeft === 0) {
    return;
  }
  hintsLeft--;
  undone = [];
  while (true) {
    res = hintOne();
    if (res != null || hist.length === 0) {
      for (j = 0, len = undone.length; j < len; j++) {
        u = undone[j];
        print("Undo: " + u);
      }
      print("Move " + res);
      return;
    }
    card = hist.pop();
    undone.push(undoMove(card));
  }
};

hintOne = function hintOne() {
  var cand, dst, hintTime, increment, nr, origBoard, path, s, src;
  hintTime = millis();
  aceCards = countAceCards(board);
  if (aceCards === N * 4) {
    return;
  }
  cands = [];
  cands.push([aceCards, hist.length, board, // antal kort på ässen, antal drag, board
  []]);
  hash = {};
  nr = 0;
  cand = null;
  origBoard = _.cloneDeep(board);
  while (nr < LIMIT && cands.length > 0 && aceCards < N * 4) {
    nr++;
    cand = cands.pop();
    aceCards = cand[0];
    if (aceCards < N * 4) {
      increment = expand(cand);
      cands = cands.concat(increment);
      cands.sort(function (a, b) {
        if (a[0] === b[0]) {
          return b[1] - a[1];
        } else {
          return a[0] - b[0];
        }
      });
    }
  }
  if (aceCards === N * 4) {
    board = cand[2];
    path = cand[3];
    board = origBoard;

    var _path$ = _slicedToArray(path[0], 2);

    src = _path$[0];
    dst = _path$[1];

    s = prettyMove(src, dst, board);
    makeMove(board, src, dst, true);
    print("hint: " + int(millis() - hintTime) + " ms");
    return s;
  } else {
    board = origBoard;
    return null;
  }
};

newGame = function newGame(key) {
  var cand, increment, level, nr;
  start = millis();
  msg = '';
  hist = [];
  classic = key === 'C';
  while (true) {
    if (indexOf.call('3456789TJQK', key) >= 0) {
      makeBoard(3 + '3456789TJQK'.indexOf(key), classic);
    }
    if (indexOf.call('C', key) >= 0) {
      makeBoard(13, classic);
    }
    maxHints = N;
    hintsLeft = maxHints;
    originalBoard = _.cloneDeep(board);
    aceCards = countAceCards(board);
    cands = [];
    cands.push([aceCards, 0, board, // antal kort på ässen, antal drag, board
    []]);
    hash = {};
    nr = 0;
    cand = null;
    //print LIMIT,N,nr,cands.length,aceCards
    while (nr < LIMIT && cands.length > 0 && aceCards < N * 4) {
      nr++;
      cand = cands.pop();
      aceCards = cand[0];
      increment = expand(cand);
      cands = cands.concat(increment);
      cands.sort(function (a, b) {
        if (a[0] === b[0]) {
          return b[1] - a[1];
        } else {
          return a[0] - b[0];
        }
      });
    }
    level = cand[1];
    print(nr, aceCards, level);
    if (aceCards === N * 4) {
      //print 'heapsize',_.size(hash)
      print(JSON.stringify(originalBoard));
      board = cand[2];
      printSolution(hash, board);
      board = _.cloneDeep(originalBoard);
      print(int(millis() - start) + " ms");
      start = millis();
      return;
    }
  }
};

restart = function restart() {
  hist = [];
  return board = _.cloneDeep(originalBoard);
};

nextLevel = function nextLevel() {
  if (4 * N === countAceCards(board)) {
    N++;
  } else {
    N--;
  }
  N = constrain(N, 3, 13);
  classic = false;
  return newGame('   3456789TJQK'[N]);
};

keyPressed = function keyPressed() {
  if (key === 'U' && hist.length > 0) {
    undoMove(hist.pop());
  }
  if (key === 'R') {
    restart();
  }
  if (indexOf.call('3456789TJQKC', key) >= 0) {
    newGame(key);
  }
  if (key === 'A') {
    shake = !shake;
  }
  if (key === ' ') {
    nextLevel();
  }
  if (key === 'H') {
    hint();
  }
  return display(board);
};

prettyCard = function prettyCard(card) {
  var antal = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 2;

  var suit, unvisible, visible;

  var _unpack23 = unpack(card);

  var _unpack24 = _slicedToArray(_unpack23, 3);

  suit = _unpack24[0];
  unvisible = _unpack24[1];
  visible = _unpack24[2];

  if (antal === 1) {
    return "" + RANK[visible];
  } else {
    return SUIT[suit] + " " + RANK[visible];
  }
};

assert("diamond 3", prettyCard(pack(3, 2)));

assert("3", prettyCard(pack(3, 2), 1));

prettyMove = function prettyMove(src, dst, b) {
  var c1, c2;
  c1 = _.last(b[src]);
  if (b[dst].length > 0) {
    c2 = _.last(b[dst]);
    return prettyCard(c1) + " to " + prettyCard(c2, 1);
  } else {
    if (indexOf.call(HEAPS, dst) >= 0) {
      return prettyCard(c1) + " to hole";
    } else {
      return prettyCard(c1) + " to panel";
    }
  }
};

printSolution = function printSolution(hash, b) {
  var dst, index, j, key, len, path, s, solution, src;
  key = makeKey(b);
  solution = [];
  while (key in hash) {
    var _hash$key = _slicedToArray(hash[key], 2);

    path = _hash$key[0];
    b = _hash$key[1];

    solution.push(hash[key]);
    key = makeKey(b);
  }
  solution.reverse();
  s = '';
  for (index = j = 0, len = solution.length; j < len; index = ++j) {
    var _solution$index = _slicedToArray(solution[index], 2);

    path = _solution$index[0];
    b = _solution$index[1];

    var _$last = _.last(path);

    var _$last2 = _slicedToArray(_$last, 2);

    src = _$last2[0];
    dst = _$last2[1];

    s += "\n" + index + ": " + prettyMove(src, dst, b);
  }
  return print(s);
};
//# sourceMappingURL=sketch.js.map
