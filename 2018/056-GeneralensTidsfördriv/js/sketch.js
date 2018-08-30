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

// I vissa situationer vill man styra one click.
// Exempel:
// Vid klick på 6 vill man ha 7,6 istf 5,6
// 5     3,4,6      7
// Tidigare
// 5,6   3,4        7
// samt klick på 6 ger
//                  7,6,5
// men man vill kanske ha
// 5     3,4        7,6
var ACES,
    H,
    HEAPS,
    LIMIT,
    LONG,
    N,
    OFFSETX,
    PANEL,
    RANK,
    Rank,
    SUIT,
    Suit,
    W,
    aceCards,
    assert,
    backs,
    board,
    calcAntal,
    cands,
    cards,
    classic,
    compress,
    compressOne,
    countAceCards,
    countPanelCards,
    counter,
    display,
    dsts,
    dumpBoard,
    expand,
    faces,
    fakeBoard,
    findAllMoves,
    h,
    hash,
    hint,
    hintOne,
    hintsUsed,
    hist,
    keyPressed,
    legalMove,
    makeBoard,
    makeMove,
    menu1,
    menu2,
    menu3,
    mousePressed,
    msg,
    newGame,
    nextLevel,
    originalBoard,
    pack,
    preload,
    prettyCard,
    prettyCard2,
    prettyMove,
    prettyUndoMove,
    print,
    printAutomaticSolution,
    printManualSolution,
    range,
    readBoard,
    restart,
    setup,
    showDialogue,
    showHeap,
    srcs,
    start,
    undoMove,
    undoMoveOne,
    unpack,
    w,
    indexOf = [].indexOf;

ACES = [0, 1, 2, 3];

HEAPS = [4, 5, 6, 7, 8, 9, 10, 11];

PANEL = [12, 13, 14, 15, 16, 17, 18, 19];

Suit = 'chsd';

Rank = "A23456789TJQK";

SUIT = "club heart spade diamond".split(' ');

RANK = "A23456789TJQK";

LONG = " Ace Two Three Four Five Six Seven Eight Nine Ten Jack Queen King Classic".split(' ');

// Konstanter för cards.png
OFFSETX = 468;

W = 263.25;

H = 352;

w = null;

h = null;

LIMIT = 1000; // Maximum steps considered before giving up. 1000 is too low, hint fails sometimes.

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

N = null; // Max rank

classic = false;

srcs = null;

dsts = null;

hintsUsed = null;

counter = 0;

print = console.log;

range = _.range;

assert = function assert(a, b) {
  var msg = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 'Assert failure';

  return chai.assert.deepEqual(a, b, msg);
};

preload = function preload() {
  faces = loadImage('cards/Color_52_Faces_v.2.0.png');
  return backs = loadImage('cards/Playing_Card_Backs.png');
};

pack = function pack(suit, under, over) {
  return Suit[suit] + RANK[under] + (under === over ? '' : RANK[over]);
};

assert('cA', pack(0, 0, 0));

assert('dA', pack(3, 0, 0));

assert('d2', pack(3, 1, 1));

assert('hJQ', pack(1, 10, 11));

assert('hJ', pack(1, 10, 10));

//print 'pack ok'
unpack = function unpack(n) {
  var over, suit, under;
  suit = Suit.indexOf(n[0]);
  under = RANK.indexOf(n[1]);
  if (n.length === 3) {
    over = RANK.indexOf(n[2]);
  } else {
    over = under;
  }
  return [suit, under, over];
};

assert([0, 0, 0], unpack('cA'));

assert([3, 0, 0], unpack('dA'));

assert([1, 10, 11], unpack('hJQ'));

assert([1, 10, 10], unpack('hJ'));

//print 'unpack ok'
compress = function compress(board) {
  var heap, j, len, results;
  results = [];
  for (j = 0, len = HEAPS.length; j < len; j++) {
    heap = HEAPS[j];
    results.push(board[heap] = compressOne(board[heap]));
  }
  return results;
};

compressOne = function compressOne(cards) {
  var i, j, len, over1, over2, ref, ref1, res, suit1, suit2, temp, under1, under2;
  if (cards.length > 1) {
    res = [];
    temp = cards[0];
    ref = range(1, cards.length);
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];

      // understa
      var _unpack = unpack(temp);

      var _unpack2 = _slicedToArray(_unpack, 3);

      suit1 = _unpack2[0];
      under1 = _unpack2[1];
      over1 = _unpack2[2];

      var _unpack3 = unpack(cards[i]);

      var _unpack4 = _slicedToArray(_unpack3, 3);

      suit2 = _unpack4[0];
      under2 = _unpack4[1];
      over2 = _unpack4[2];

      if (suit1 === suit2 && ((ref1 = under2 - over1) === -1 || ref1 === 1)) {
        temp = pack(suit1, under1, over2);
      } else {
        res.push(temp);
        temp = pack(suit2, under2, over2);
      }
    }
    res.push(temp);
    return res;
  } else {
    return cards;
  }
};

assert([], compressOne([]));

assert(['cA'], compressOne(['cA']));

assert(['cA2'], compressOne(['cA', 'c2']));

assert(['c23'], compressOne(['c2', 'c3']));

assert(['cA4'], compressOne(['cA2', 'c34']));

assert(['cA3'], compressOne(['cA', 'c2', 'c3']));

assert(['cA6'], compressOne(['cA2', 'c34', 'c56']));

assert(['cA2', 'h34', 'c56'], compressOne(['cA2', 'h34', 'c56']));

//print 'compressOne ok'
dumpBoard = function dumpBoard(board) {
  var heap;
  return function () {
    var j, len, results;
    results = [];
    for (j = 0, len = board.length; j < len; j++) {
      heap = board[j];
      results.push(heap.join(' '));
    }
    return results;
  }().join('|');
};

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
      cards.push(pack(suit, rank, rank));
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
    board[heap].push(pack(suit, 0, 0)); // Ess
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

readBoard = function readBoard(b) {
  var heap, j, len, ref, results;
  ref = b.split('|');
  results = [];
  for (j = 0, len = ref.length; j < len; j++) {
    heap = ref[j];
    results.push(heap === '' ? [] : heap.split(' '));
  }
  return results;
};

fakeBoard = function fakeBoard() {
  N = 13;
  classic = false;
  if (N === 13) {
    board = "cA|hA|sA|dA|h6 s8 h3 s2 d5|dJ s3 c9 d7|sK h7 dQ s5 h5 d34|cQ sJ dT d6|c7 cK hT d2 s4 c8|sQ s7 cJ s9T h9|h8 c56 c4 hJ d8|cT c3|c2|h2|h4|s6|d9|hQ|hK|dK";
  }
  if (N === 13) {
    board = "cA|hA|sA|dA|c5 c7 h2 d7 c9 s6 c3 d8 s9|h8 dQ cQK dK h7 s2 dT|c4 sJQ d5||hQ h54 c8 h3 d3|cJT s4 c6 s8 hJT|d2 d4 s5|h9 sK s3|d6|d9|sT|h6|s7|hK|dJ|c2";
  }
  if (N === 13) {
    board = "cA2|hA|sA|dA|c5 c7 h2 d7 c9 s6 c3 d8 s9|h8 dQ cQK dK h7 s2 dT|c4 sJQ d5||hQ h54 c8 h3 d3|cJT s4 c6 s8 hJT|d2 d4 s5|h9 sK s3|d6|d9|sT|h6|s7|hK|dJ|";
  }
  if (N === 13) {
    board = "cA2|hA|sA|dA|c5 c7 h2 d7 c9 s6 c3 d8 s9|h8 dQ cQK dK h7 s2 dT|c4 sJQ d5|s5|hQ h54 c8 h3 d3|cJT s4 c6 s8 hJT|d2 d4|h9 sK s3|d6|d9|sT|h6|s7|hK|dJ|";
  }
  if (N === 13) {
    board = "cA|hA|sA|dA|c9 h3 s8|h5 s7 sJ hK h4 s3 c7 hT s4|s9 d2|s5 d7 c4|s6 h9|c3 d3 h6|d6 d8 dK sT s2 c5 cK c6 c8 d4 h2|dT hQ cT d5 hJ dJ cJ|c2|d9|sQ|cQ|h7|dQ|sK|h8";
  }
  if (N === 13) {
    board = "cA|hA|sA|dA|s4 cJ s3 c3 dK hJ cQ c2 h4|sQK|s9 d2 dT|s2 dQ sJ hT|d8 h3 d7 h5 h2 c9|d3 s6 sT d9 c7 c4|cK c8 h7 c5|dJ hK s87 s5 cT|d6|h9|d4|h8|d5|h6|c6|hQ";
  }
  board = readBoard(board);
  return print(board);
};

setup = function setup() {
  print('Z');
  createCanvas(innerWidth, innerHeight - 0.5);
  w = width / 9;
  h = height / 4;
  angleMode(DEGREES);
  newGame('3');
  menu1();
  return display(board);
};

keyPressed = function keyPressed() {
  if (key === 'X') {
    N = 7;
    board = "cA7|hA4|sA3|dA2||h6|s5 d6||h5 d5||s4 s6|d34||d7|s7|h7||||";
    hist = [[12, 0, 1], [5, 1, 1], [8, 3, 1], [9, 1, 1], [11, 1, 1], [16, 2, 1], [17, 0, 1], [10, 0, 1], [9, 0, 1], [18, 2, 1], [19, 0, 1], [7, 0, 1]];
    board = readBoard(board);
    print(board);
  }
  return display(board);
};

menu1 = function menu1() {
  var dialogue;
  dialogue = new Dialogue(width / 2, height / 2, 0.12 * h);
  dialogue.add(new Button('Undo', 4 * w, -h, 0.2 * h, function () {
    if (hist.length > 0) {
      return undoMove(hist.pop());
    }
  }));
  dialogue.add(new Button('Menu', 4 * w, 0, 0.2 * h, function () {
    return menu2();
  }));
  return dialogue.add(new Button('Hint', 4 * w, h, 0.2 * h, function () {
    return hint();
  }));
};

menu2 = function menu2() {
  var dialogue, r1, r2;
  dialogue = new Dialogue(width / 2, height / 2, 0.15 * h);
  r1 = 0.25 * height;
  r2 = 0.085 * height;
  dialogue.clock(4, r1, r2, 45);
  dialogue.buttons[0].info('Restart', function () {
    restart();
    return dialogues.pop();
  });
  dialogue.buttons[1].info('Next', function () {
    nextLevel();
    return dialogues.pop();
  });
  dialogue.buttons[2].info('Link');
  return dialogue.buttons[3].info('Level', function () {
    return menu3();
  });
};

menu3 = function menu3() {
  var dialogue, i, j, len, level, r1, r2, ref, results;
  dialogue = new Dialogue(width / 2, height / 2, 0.15 * h);
  r1 = 0.35 * height;
  r2 = 0.085 * height;
  dialogue.clock(12, r1, r2);
  ref = LONG.slice(3);
  results = [];
  for (i = j = 0, len = ref.length; j < len; i = ++j) {
    level = ref[i];
    results.push(function () {
      var button, index;
      button = dialogue.buttons[i];
      index = i + 2;
      button.txt = level;
      return button.event = function () {
        newGame("A23456789TJQKC"[index]);
        dialogues.pop();
        return dialogues.pop();
      };
    }());
  }
  return results;
};

showHeap = function showHeap(board, heap, x, y, dy) {
  // dx kan vara både pos och neg
  var card, dr, j, k, l, len, len1, n, over, rank, ref, ref1, suit, under;
  n = calcAntal(board[heap]);
  if (n === 0) {
    return;
  }
  y = y * h + y * dy;
  x = x * w;
  ref = board[heap];
  for (k = j = 0, len = ref.length; j < len; k = ++j) {
    card = ref[k];

    var _unpack5 = unpack(card);

    var _unpack6 = _slicedToArray(_unpack5, 3);

    suit = _unpack6[0];
    under = _unpack6[1];
    over = _unpack6[2];

    dr = under < over ? 1 : -1;
    ref1 = range(under, over + dr, dr);
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      rank = ref1[l];
      noFill();
      stroke(0);
      image(faces, x, y, w, h * 1.1, OFFSETX + W * rank, 1092 + H * suit, 225, H - 1);
      y += dy;
    }
  }
  // visa eventuellt baksidan
  card = _.last(board[heap]);

  var _unpack7 = unpack(card);

  var _unpack8 = _slicedToArray(_unpack7, 3);

  suit = _unpack8[0];
  under = _unpack8[1];
  over = _unpack8[2];

  if (indexOf.call(ACES, heap) >= 0 && over === N - 1) {
    return image(backs, x, y, w, h * 1.1, OFFSETX + 860, 1092 + 622, 225, H - 1);
  }
};

display = function display(board) {
  var dy, heap, j, l, len, len1, len2, m, n, x, y;
  background(0, 128, 0);
  textAlign(LEFT, BOTTOM);
  fill(0, 128 - 16, 0);
  textSize(0.2 * h);
  text('Generalens Tidsfördriv', 0, 3 * h);
  textAlign(RIGHT, BOTTOM);
  text(classic ? 'Classic' : LONG[N], 8 * w, 3 * h);
  textAlign(CENTER, TOP);
  if (hintsUsed === 0) {
    text(msg, width / 2, height / 2);
  }
  for (y = j = 0, len = ACES.length; j < len; y = ++j) {
    heap = ACES[y];
    showHeap(board, heap, 8, y, 0);
  }
  for (x = l = 0, len1 = HEAPS.length; l < len1; x = ++l) {
    heap = HEAPS[x];
    n = calcAntal(board[heap]);
    dy = min(h / 4, (2 - 0.05) * h / (n - 1));
    showHeap(board, heap, x, 0, dy);
  }
  for (x = m = 0, len2 = PANEL.length; m < len2; x = ++m) {
    heap = PANEL[x];
    showHeap(board, heap, x, 3, 0);
  }
  noStroke();
  dialogues[0].buttons[0].txt = ['Undo', hist.length];
  dialogues[0].buttons[2].txt = ['Hint', hintsUsed];
  return showDialogue();
};

showDialogue = function showDialogue() {
  return _.last(dialogues).show();
};

legalMove = function legalMove(board, src, dst) {
  var over1, over2, suit1, suit2, under1, under2;
  if (indexOf.call(ACES, src) >= 0) {
    return false;
  }
  if (indexOf.call(PANEL, dst) >= 0) {
    return false;
  }
  if (board[src].length === 0) {
    return false;
  }
  if (board[dst].length === 0) {
    return true;
  }

  var _unpack9 = unpack(_.last(board[src]));

  var _unpack10 = _slicedToArray(_unpack9, 3);

  suit1 = _unpack10[0];
  under1 = _unpack10[1];
  over1 = _unpack10[2];

  var _unpack11 = unpack(_.last(board[dst]));

  var _unpack12 = _slicedToArray(_unpack11, 3);

  suit2 = _unpack12[0];
  under2 = _unpack12[1];
  over2 = _unpack12[2];

  if (suit1 === suit2 && abs(over1 - over2) === 1) {
    return true;
  }
  return false;
};

makeMove = function makeMove(board, src, dst, record) {
  var over, over1, over2, suit, suit2, under, under1, under2;

  var _unpack13 = unpack(board[src].pop());

  var _unpack14 = _slicedToArray(_unpack13, 3);

  suit = _unpack14[0];
  under1 = _unpack14[1];
  over1 = _unpack14[2];

  over = under1;
  under = over1;
  if (record) {
    hist.push([src, dst, 1 + abs(under1 - over1)]);
  }
  if (board[dst].length > 0) {
    var _unpack15 = unpack(board[dst].pop());

    var _unpack16 = _slicedToArray(_unpack15, 3);

    suit2 = _unpack16[0];
    under2 = _unpack16[1];
    over2 = _unpack16[2];

    under = under2;
  }
  return board[dst].push(pack(suit, under, over));
};

// returns text move
undoMove = function undoMove(_ref) {
  var _ref2 = _slicedToArray(_ref, 3),
      src = _ref2[0],
      dst = _ref2[1],
      antal = _ref2[2];

  var res;
  msg = '';
  res = prettyUndoMove(src, dst, board, antal);

  var _undoMoveOne = undoMoveOne(board[src], board[dst], antal);

  var _undoMoveOne2 = _slicedToArray(_undoMoveOne, 2);

  board[src] = _undoMoveOne2[0];
  board[dst] = _undoMoveOne2[1];

  return res;
};

undoMoveOne = function undoMoveOne(a, b, antal) {
  var over, suit, under;

  var _unpack17 = unpack(b.pop());

  var _unpack18 = _slicedToArray(_unpack17, 3);

  suit = _unpack18[0];
  under = _unpack18[1];
  over = _unpack18[2];

  if (under < over) {
    a.push(pack(suit, over, over - antal + 1));
    if (over - under !== antal - 1) {
      b.push(pack(suit, under, over - antal));
    }
  } else {
    a.push(pack(suit, over, over + antal - 1));
    if (under - over !== antal - 1) {
      b.push(pack(suit, under, over + antal));
    }
  }
  return [a, b];
};

assert([['d9T'], ['dJ']], undoMoveOne([], ['dJ9'], 2));

assert([['d9'], ['dJT']], undoMoveOne([], ['dJ9'], 1));

prettyUndoMove = function prettyUndoMove(src, dst, b, antal) {
  var c1, c2;
  c2 = _.last(b[dst]);
  if (b[src].length > 0) {
    c1 = _.last(b[src]);
    return prettyCard2(c2, antal) + " to " + prettyCard(c1);
  } else {
    if (indexOf.call(HEAPS, src) >= 0) {
      prettyCard2(c2, antal) + " to hole";
    }
    if (indexOf.call(PANEL, src) >= 0) {
      return prettyCard2(c2, antal) + " to panel";
    }
  }
};

mousePressed = function mousePressed() {
  var alternativeDsts, dialogue, found, heap, holes, j, l, len, len1, len2, m, marked, mx, my;
  if (!(0 < mouseX && mouseX < width)) {
    return;
  }
  if (!(0 < mouseY && mouseY < height)) {
    return;
  }
  dialogue = _.last(dialogues);
  if (!dialogue.execute(mouseX, mouseY)) {
    counter++;
    marked = null;
    mx = Math.floor(mouseX / w);
    my = Math.floor(mouseY / h);
    if (mx === 8) {
      marked = my;
    } else {
      marked = mx + (my >= 3 ? 12 : 4);
    }
    if (marked !== null) {
      holes = [];
      found = false;
      for (j = 0, len = ACES.length; j < len; j++) {
        heap = ACES[j];
        if (legalMove(board, marked, heap)) {
          makeMove(board, marked, heap, true);
          found = true;
          break;
        }
      }
      if (!found) {
        alternativeDsts = []; // för att kunna välja mellan flera via Undo
        for (l = 0, len1 = HEAPS.length; l < len1; l++) {
          heap = HEAPS[l];
          if (board[heap].length === 0) {
            holes.push(heap);
          }
          // if heap not in holes and legalMove board,marked,heap  
          if (legalMove(board, marked, heap)) {
            alternativeDsts.push(heap);
          }
        }
        if (alternativeDsts.length > 0) {
          heap = alternativeDsts[counter % alternativeDsts.length];
          makeMove(board, marked, heap, true);
          found = true;
        }
        if (!found) {
          for (m = 0, len2 = holes.length; m < len2; m++) {
            heap = holes[m];
            if (legalMove(board, marked, heap)) {
              makeMove(board, marked, heap, true);
              break;
            }
          }
        }
      }
      if (4 * N === countAceCards(board)) {
        msg = Math.floor((millis() - start) / 1000) + " s";
        printManualSolution();
      }
    }
  }
  print(JSON.stringify(dumpBoard(board)));
  print(JSON.stringify(hist));
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

calcAntal = function calcAntal(lst) {
  var card, j, len, over, res, suit, under;
  res = 0;
  for (j = 0, len = lst.length; j < len; j++) {
    card = lst[j];

    var _unpack19 = unpack(card);

    var _unpack20 = _slicedToArray(_unpack19, 3);

    suit = _unpack20[0];
    under = _unpack20[1];
    over = _unpack20[2];

    res += 1 + abs(under - over);
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

countPanelCards = function countPanelCards(b) {
  var heap, j, len, res;
  res = 0;
  for (j = 0, len = PANEL.length; j < len; j++) {
    heap = PANEL[j];
    res += b[heap].length;
  }
  return res;
};

expand = function expand(_ref3) {
  var _ref4 = _slicedToArray(_ref3, 4),
      aceCards = _ref4[0],
      level = _ref4[1],
      b = _ref4[2],
      path = _ref4[3];

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
    key = dumpBoard(b1);
    if (!(key in hash)) {
      newPath = path.concat([move]);
      hash[key] = [newPath, b];
      res.push([countAceCards(b1), level + 1, b1, path.concat([move])]);
    }
  }
  return res;
};

hint = function hint() {
  var res;
  if (4 * N === countAceCards(board)) {
    return;
  }
  hintsUsed++;
  res = hintOne();
  if (res || hist.length === 0) {
    return;
  }
  return undoMove(hist.pop());
};

hintOne = function hintOne() {
  var cand, dst, hintTime, increment, nr, origBoard, path, src;
  hintTime = millis();
  aceCards = countAceCards(board);
  if (aceCards === N * 4) {
    return true;
  }
  cands = [];
  cands.push([aceCards, hist.length, board, // antal kort på ässen, antal drag, board
  []]);
  hash = {};
  nr = 0;
  cand = null;
  origBoard = _.cloneDeep(board);
  while (nr < 10000 && cands.length > 0 && aceCards < N * 4) {
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
  print(N, nr, cands.length, aceCards);
  if (aceCards === N * 4) {
    board = cand[2];
    //printAutomaticSolution hash, board
    path = cand[3];
    board = origBoard;

    var _path$ = _slicedToArray(path[0], 2);

    src = _path$[0];
    dst = _path$[1];

    makeMove(board, src, dst, true);
    print("hint: " + int(millis() - hintTime) + " ms");
    return true;
  } else {
    print('hint failed. Should never happen!');
    print(N, nr, cands.length, aceCards, _.size(hash));
    board = origBoard;
    return false;
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
    hintsUsed = 0;
    originalBoard = _.cloneDeep(board);
    aceCards = countAceCards(board);
    cands = [];
    cands.push([aceCards, 0, board, // antal kort på ässen, antal drag, board
    []]);
    hash = {};
    nr = 0;
    cand = null;
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
    print(nr, aceCards, level, _.size(hash));
    if (aceCards === N * 4) {
      print(JSON.stringify(dumpBoard(originalBoard)));
      board = cand[2];
      printAutomaticSolution(hash, board);
      board = _.cloneDeep(originalBoard);
      print(int(millis() - start) + " ms");
      start = millis();
      return;
    }
  }
};

restart = function restart() {
  hist = [];
  board = _.cloneDeep(originalBoard);
  return msg = '';
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

prettyCard2 = function prettyCard2(card, antal) {
  var over, suit, under;

  var _unpack21 = unpack(card);

  var _unpack22 = _slicedToArray(_unpack21, 3);

  suit = _unpack22[0];
  under = _unpack22[1];
  over = _unpack22[2];

  if (antal === 1) {
    return SUIT[suit] + " " + RANK[over];
  } else {
    if (under < over) {
      return SUIT[suit] + " " + RANK[over] + ".." + RANK[over - antal + 1];
    } else {
      return SUIT[suit] + " " + RANK[over] + ".." + RANK[over + antal - 1];
    }
  }
};

prettyCard = function prettyCard(card) {
  var antal = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 2;

  var over, suit, under;

  var _unpack23 = unpack(card);

  var _unpack24 = _slicedToArray(_unpack23, 3);

  suit = _unpack24[0];
  under = _unpack24[1];
  over = _unpack24[2];

  if (antal === 1) {
    return "" + RANK[over];
  } else {
    return SUIT[suit] + " " + RANK[over];
  }
};

assert("club A", prettyCard(pack(0, 0, 0)));

assert("club T", prettyCard(pack(0, 9, 9)));

assert("heart J", prettyCard(pack(1, 10, 10)));

assert("spade Q", prettyCard(pack(2, 11, 11)));

assert("diamond K", prettyCard(pack(3, 12, 12)));

assert("3", prettyCard(pack(3, 2, 2), 1));

//print 'prettyCard ok'
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

printAutomaticSolution = function printAutomaticSolution(hash, b) {
  var dst, index, j, key, len, path, s, solution, src;
  key = dumpBoard(b);
  solution = [];
  while (key in hash) {
    var _hash$key = _slicedToArray(hash[key], 2);

    path = _hash$key[0];
    b = _hash$key[1];

    solution.push(hash[key]);
    key = dumpBoard(b);
  }
  solution.reverse();
  s = 'Automatic Solution:';
  for (index = j = 0, len = solution.length; j < len; index = ++j) {
    var _solution$index = _slicedToArray(solution[index], 2);

    path = _solution$index[0];
    b = _solution$index[1];

    var _$last = _.last(path);

    var _$last2 = _slicedToArray(_$last, 2);

    src = _$last2[0];
    dst = _$last2[1];

    s += "\n" + index + ": " + prettyMove(src, dst, b) + " (" + src + " to " + dst + ")";
  }
  return print(s);
};

printManualSolution = function printManualSolution() {
  var antal, b, dst, index, j, len, s, src;
  b = _.cloneDeep(originalBoard);
  s = 'Manual Solution:';
  for (index = j = 0, len = hist.length; j < len; index = ++j) {
    var _hist$index = _slicedToArray(hist[index], 3);

    src = _hist$index[0];
    dst = _hist$index[1];
    antal = _hist$index[2];

    print("pMS", src, dst, antal);
    s += "\n" + index + ": " + prettyMove(src, dst, b);
    makeMove(b, src, dst, false);
  }
  return print(s);
};
//# sourceMappingURL=sketch.js.map
