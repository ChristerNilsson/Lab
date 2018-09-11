"use strict";

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

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
    General,
    H,
    HEAPS,
    LIMIT,
    LONG,
    N,
    OFFSETX,
    PANEL,
    RANK,
    Rank,
    SEQS,
    SUIT,
    Suit,
    W,
    aceCards,
    assert,
    b1,
    b1a,
    b2,
    backs,
    board,
    calcAntal,
    cands,
    cards,
    compress,
    compressOne,
    copyToClipboard,
    countAceCards,
    countPanelCards,
    currentSeed,
    display,
    dsts,
    dumpBoard,
    expand,
    faces,
    fakeBoard,
    findAllMoves,
    general,
    getParameters,
    h,
    hash,
    hint,
    hintOne,
    hitGreen,
    indicators,
    infoLines,
    keyPressed,
    legalMove,
    makeBoard,
    makeLink,
    makeMove,
    menu1,
    menu2,
    mousePressed,
    myRandom,
    myShuffle,
    newGame,
    oneClick,
    oneClickData,
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
    seed,
    setup,
    showDialogue,
    showHeap,
    showIndicator,
    showInfo,
    srcs,
    startCompetition,
    text3,
    undoMove,
    undoMoveOne,
    unpack,
    w,
    indexOf = [].indexOf;

SEQS = 8; // 6: kan fungera, 4: tar mkt lång tid att skapa problem

ACES = [0, 1, 2, 3];

HEAPS = [4, 5, 6, 7, 8, 9, 10, 11].slice(0, SEQS);

PANEL = [12, 13, 14, 15, 16, 17, 18, 19].slice(0, SEQS);

Suit = 'chsd';

Rank = "A23456789TJQK";

SUIT = "club heart spade diamond".split(' ');

RANK = "A23456789TJQK";

LONG = " Ace Two Three Four Five Six Seven Eight Nine Ten Jack Queen King".split(' ');

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

cands = null;

hash = null;

aceCards = 4;

originalBoard = null;

startCompetition = null;

N = null; // Max rank

//classic = false
srcs = null;

dsts = null;

oneClickData = {
  lastMarked: -1,
  counter: 0
};

indicators = {}; // färgmarkering av senaste undo eller hint. [color,hollow]

seed = 1; // seed for random numbers

currentSeed = null;

infoLines = [];

general = null;

print = console.log;

range = _.range;

assert = function assert(a, b) {
  var msg = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 'Assert failure';

  return chai.assert.deepEqual(a, b, msg);
};

getParameters = function getParameters() {
  var h = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : window.location.href;

  var arr, f, s;
  h = decodeURI(h);
  arr = h.split('?');
  if (arr.length !== 2) {
    return {};
  }
  s = arr[1];
  if (s === '') {
    return {};
  }
  return _.fromPairs(function () {
    var l, len, ref, results;
    ref = s.split('&');
    results = [];
    for (l = 0, len = ref.length; l < len; l++) {
      f = ref[l];
      results.push(f.split('='));
    }
    return results;
  }());
};

myRandom = function myRandom(a, b) {
  var r, x;
  x = 10000 * Math.sin(seed++);
  r = x - Math.floor(x);
  return a + Math.floor((b - a) * r);
};

myShuffle = function myShuffle(array) {
  var i, j, l, len, n, ref, results, value;
  n = array.length;
  ref = range(n);
  results = [];
  for (l = 0, len = ref.length; l < len; l++) {
    i = ref[l];
    j = myRandom(i, n);
    value = array[i];
    array[i] = array[j];
    results.push(array[j] = value);
  }
  return results;
};

copyToClipboard = function copyToClipboard(txt) {
  var copyText;
  copyText = document.getElementById("myClipboard");
  copyText.value = txt;
  copyText.select();
  return document.execCommand("copy");
};

makeLink = function makeLink() {
  var index, url;
  url = window.location.href + '?';
  index = url.indexOf('?');
  url = url.substring(0, index);
  url += '?seed=' + currentSeed;
  url += '&level=' + general.level;
  return url;
};

General = function () {
  function General() {
    _classCallCheck(this, General);

    this.competition = false;
    this.timeUsed = 0;
    this.start = null;
    this.level = 0;
    this.maxLevel = 0;
    this.maxMoves = null;
    this.races = []; // [time,computer,human]
    this.hist = null;
    this.hintsUsed = null;
  }

  _createClass(General, [{
    key: "handle",
    value: function handle(mx, my) {
      var heap, marked, msg;
      marked = [mx + (my >= 3 ? 12 : 4), my];
      heap = oneClick(oneClickData, marked, board, true);
      if (this.timeUsed === 0 && 4 * N === countAceCards(board)) {
        if (this.competition) {
          if (this.success(true)) {
            this.timeUsed = Math.floor((millis() - this.start) / 1000);
            if (this.level === this.maxLevel) {
              this.maxLevel++;
              this.races.push([this.timeUsed, this.maxMoves, this.hist.length]);
              print('handle', this.races);
            }
          }
        } else {
          if (this.hist.length > this.maxMoves * 1.1) {
            msg = "Too many moves: " + (this.hist.length - this.maxMoves);
          } else if (this.hintsUsed === 0) {
            this.timeUsed = Math.floor((millis() - this.start) / 1000);
            if (this.level === this.maxLevel) {
              this.maxLevel++;
            }
          }
        }
        this.maxLevel = constrain(this.maxLevel, 0, 15);
        return localStorage.Generalen = JSON.stringify({ maxLevel: this.maxLevel, level: this.level });
      }
    }

    //printManualSolution()

  }, {
    key: "success",
    value: function success() {
      var init = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : true;

      var computer, human, l, len, ref, res, time, totalComputer, totalHuman;
      print('success0', init);
      if (!this.competition) {
        return true;
      }
      print('success1');
      if (4 * N !== countAceCards(board)) {
        return false;
      }
      print('success2');
      totalComputer = init ? this.maxMoves : 0;
      totalHuman = init ? this.hist.length : 0;
      print('success4', totalHuman, totalComputer);
      ref = this.races;
      for (l = 0, len = ref.length; l < len; l++) {
        var _ref$l = _slicedToArray(ref[l], 3);

        time = _ref$l[0];
        computer = _ref$l[1];
        human = _ref$l[2];

        totalComputer += computer;
        totalHuman += human;
      }
      res = totalHuman <= totalComputer;
      print('success5', totalHuman, totalComputer, res);
      return res;
    }
  }]);

  return General;
}();

// nextLevel : ->
// 	if @hist.length <= @maxMoves and @level <= @maxLevel and @hintsUsed == 0 and 4*N == countAceCards board then @level++ else @level--
// 	@level = constrain @level,0,15
// 	if @level > @maxLevel then @maxLevel = @level
// 	newGame @level
showIndicator = function showIndicator(heap, x, y) {
  var color, hollow, x0, y0;
  x0 = x + w / 2;
  y0 = y + 0.49 * h;
  if (heap in indicators) {
    var _indicators$heap = _slicedToArray(indicators[heap], 2);

    color = _indicators$heap[0];
    hollow = _indicators$heap[1];

    push();
    if (hollow) {
      stroke(0);
      strokeWeight(0.13 * h);
      arc(x0, y0, 0.4 * w, 0.4 * w, 0, 360);
      stroke(color);
      strokeWeight(0.13 * h - 2);
      arc(x0, y0, 0.4 * w, 0.4 * w, 0, 360);
    } else {
      stroke(0);
      strokeWeight(1);
      fill(color);
      ellipse(x0, y0, 0.55 * w);
    }
    return pop();
  }
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
  var heap, l, len, results;
  results = [];
  for (l = 0, len = HEAPS.length; l < len; l++) {
    heap = HEAPS[l];
    results.push(board[heap] = compressOne(board[heap]));
  }
  return results;
};

compressOne = function compressOne(cards) {
  var i, l, len, over1, over2, ref, ref1, res, suit1, suit2, temp, under1, under2;
  if (cards.length > 1) {
    res = [];
    temp = cards[0];
    ref = range(1, cards.length);
    for (l = 0, len = ref.length; l < len; l++) {
      i = ref[l];

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
calcAntal = function calcAntal(lst) {
  var card, l, len, over, res, suit, under;
  res = 0;
  for (l = 0, len = lst.length; l < len; l++) {
    card = lst[l];

    var _unpack5 = unpack(card);

    var _unpack6 = _slicedToArray(_unpack5, 3);

    suit = _unpack6[0];
    under = _unpack6[1];
    over = _unpack6[2];

    res += 1 + Math.abs(under - over);
  }
  return res;
};

countAceCards = function countAceCards(b) {
  var heap, l, len, res;
  res = 0;
  for (l = 0, len = ACES.length; l < len; l++) {
    heap = ACES[l];
    res += calcAntal(b[heap]);
  }
  return res;
};

countPanelCards = function countPanelCards(b) {
  var heap, l, len, res;
  res = 0;
  for (l = 0, len = PANEL.length; l < len; l++) {
    heap = PANEL[l];
    res += b[heap].length;
  }
  return res;
};

dumpBoard = function dumpBoard(board) {
  var heap;
  return function () {
    var l, len, results;
    results = [];
    for (l = 0, len = board.length; l < len; l++) {
      heap = board[l];
      results.push(heap.join(' '));
    }
    return results;
  }().join('|');
};

makeBoard = function makeBoard(lvl) {
  var card, classic, heap, i, l, len, len1, len2, len3, len4, len5, m, o, p, q, rank, ref, ref1, ref2, ref3, suit, t, zz;
  N = [3, 4, 5, 5, 6, 7, 7, 8, 9, 9, 10, 11, 11, 12, 13, 13][lvl];
  classic = lvl % 3 === 0;
  //N = maxRank
  cards = [];
  ref = range(4);
  for (l = 0, len = ref.length; l < len; l++) {
    suit = ref[l];
    ref1 = range(1, N);
    // 2..K
    for (m = 0, len1 = ref1.length; m < len1; m++) {
      rank = ref1[m];
      cards.push(pack(suit, rank, rank));
    }
  }
  currentSeed = seed;
  myShuffle(cards);
  board = [];
  ref2 = range(20);
  for (o = 0, len2 = ref2.length; o < len2; o++) {
    i = ref2[o];
    board.push([]);
  }
  ref3 = range(4);
  for (heap = p = 0, len3 = ref3.length; p < len3; heap = ++p) {
    suit = ref3[heap];
    board[heap].push(pack(suit, 0, 0)); // Ess
  }
  for (q = 0, len4 = PANEL.length; q < len4; q++) {
    heap = PANEL[q];
    board[heap].push(cards.pop());
  }
  for (i = t = 0, len5 = cards.length; t < len5; i = ++t) {
    card = cards[i];
    zz = classic ? 4 + i % SEQS : myRandom(4, 4 + SEQS);
    board[zz].push(card);
  }
  return compress(board);
};

readBoard = function readBoard(b) {
  var heap, l, len, ref, results;
  ref = b.split('|');
  results = [];
  for (l = 0, len = ref.length; l < len; l++) {
    heap = ref[l];
    results.push(heap === '' ? [] : heap.split(' '));
  }
  return results;
};

fakeBoard = function fakeBoard() {
  var classic;
  N = 6;
  classic = false;
  if (N === 6) {
    board = "cA|hA|sA|dA|h5|c3|s65|c2 d5||s3|d2 h6 d4|d3 h4|h2|c5|c4|h3|c6|s4|s2|d6";
  }
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
  var canvas, level, maxLevel, params;
  print('X');
  canvas = createCanvas(innerWidth, innerHeight - 0.5);
  canvas.position(0, 0); // hides text field used for clipboard copy.
  general = new General();
  w = width / 9;
  h = height / 4;
  angleMode(DEGREES);
  if (localStorage.Generalen != null) {
    var _JSON$parse = JSON.parse(localStorage.Generalen);

    maxLevel = _JSON$parse.maxLevel;
    level = _JSON$parse.level;
  } else {
    var _maxLevel$level = {
      maxLevel: 0,
      level: 0
    };
    maxLevel = _maxLevel$level.maxLevel;
    level = _maxLevel$level.level;
  }
  general.maxLevel = maxLevel;
  general.level = level;
  params = getParameters();
  if ('seed' in params) {
    seed = parseInt(params.seed);
  } else {
    seed = int(random(10000));
  }
  if ('level' in params) {
    general.level = parseInt(params.level);
  }
  general.level = constrain(general.level, 0, general.maxLevel);
  startCompetition = millis();
  infoLines = [];
  infoLines.push(['', '', 'Total']);
  infoLines.push(['Levels', '', 0]);
  infoLines.push(["Computer Moves", 0, 0]);
  infoLines.push(["Human Moves", 0, 0]);
  infoLines.push(["Time", 0, 0]);
  newGame(general.level);
  return display(board);
};

keyPressed = function keyPressed() {
  if (key === 'X') {
    N = 7;
    board = "cA7|hA4|sA3|dA2||h6|s5 d6||h5 d5||s4 s6|d34||d7|s7|h7||||";
    general.hist = [[12, 0, 1], [5, 1, 1], [8, 3, 1], [9, 1, 1], [11, 1, 1], [16, 2, 1], [17, 0, 1], [10, 0, 1], [9, 0, 1], [18, 2, 1], [19, 0, 1], [7, 0, 1]];
    board = readBoard(board);
    print(board);
  }
  return display(board);
};

menu1 = function menu1() {
  var dialogue, r1, r2, s;
  dialogue = new Dialogue(4 * w, 1.5 * h, 0.15 * h);
  r1 = 0.25 * height;
  r2 = 0.085 * height;
  dialogue.clock(' ', 7, r1, r2, 90 + 360 / 14);
  dialogue.buttons[0].info('Undo', function () {
    var dst, src;
    if (general.hist.length > 0) {
      var _$last = _.last(general.hist);

      var _$last2 = _slicedToArray(_$last, 2);

      src = _$last2[0];
      dst = _$last2[1];

      indicators = {};
      indicators[src] = ["#ff0", true];
      indicators[dst] = ["#ff0", false];
      undoMove(general.hist.pop());
    }
    return dialogues.pop();
  });
  dialogue.buttons[1].info(general.competition ? '' : 'Hint', function () {
    hint();
    return dialogues.pop();
  });
  dialogue.buttons[2].info(general.competition ? '' : 'Link', function () {
    var link, msg;
    link = makeLink();
    copyToClipboard(link);
    msg = 'Link copied to clipboard';
    return dialogues.pop();
  });
  s = general.success(true) ? 'Harder' : '';
  dialogue.buttons[3].info(s, function () {
    general.level = constrain(general.level + 1, 0, general.maxLevel);
    newGame(general.level);
    general.timeUsed = 0;
    return dialogues.pop();
  });
  dialogue.buttons[4].info(general.competition ? '' : 'Go', function () {
    newGame(general.level);
    return dialogues.pop();
  });
  dialogue.buttons[5].info(general.competition ? '' : 'Easier', function () {
    general.level = constrain(general.level - 1, 0, general.maxLevel);
    newGame(general.level);
    return dialogues.pop();
  });
  return dialogue.buttons[6].info('Restart', function () {
    return menu2();
  });
};

menu2 = function menu2() {
  var dialogue, r1, r2, s;
  dialogue = new Dialogue(4 * w, 1.5 * h, 0.15 * h);
  r1 = 0.25 * height;
  r2 = 0.11 * height;
  dialogue.clock(' ', 3, r1, r2, 90 + 360 / 6);
  dialogue.buttons[0].info('Normal Restart', function () {
    restart();
    dialogues.pop();
    return dialogues.pop();
  });
  dialogue.buttons[1].info(general.competition ? '' : 'Total Restart', function () {
    delete localStorage.Generalen;
    general.races = [];
    general.maxLevel = 0;
    newGame(0);
    dialogues.pop();
    return dialogues.pop();
  });
  s = general.competition ? 'Exit Competition' : 'Start Competition';
  return dialogue.buttons[2].info(s, function () {
    general.competition = !general.competition;
    delete localStorage.Generalen;
    general.races = [];
    general.maxLevel = 0;
    newGame(0);
    dialogues.pop();
    return dialogues.pop();
  });
};

showHeap = function showHeap(board, heap, x, y, dy) {
  // dy kan vara både pos och neg
  var card, dr, k, l, len, len1, m, n, over, rank, ref, ref1, suit, under;
  n = calcAntal(board[heap]);
  x = x * w;
  if (n > 0) {
    y = y * h + y * dy;
    ref = board[heap];
    for (k = l = 0, len = ref.length; l < len; k = ++l) {
      card = ref[k];

      var _unpack7 = unpack(card);

      var _unpack8 = _slicedToArray(_unpack7, 3);

      suit = _unpack8[0];
      under = _unpack8[1];
      over = _unpack8[2];

      dr = under < over ? 1 : -1;
      ref1 = range(under, over + dr, dr);
      for (m = 0, len1 = ref1.length; m < len1; m++) {
        rank = ref1[m];
        noFill();
        stroke(0);
        image(faces, x, y, w, h * 1.1, OFFSETX + W * rank, 1092 + H * suit, 225, H - 1);
        y += dy;
      }
    }
    // visa eventuellt baksidan
    card = _.last(board[heap]);

    var _unpack9 = unpack(card);

    var _unpack10 = _slicedToArray(_unpack9, 3);

    suit = _unpack10[0];
    under = _unpack10[1];
    over = _unpack10[2];

    if (indexOf.call(ACES, heap) >= 0 && over === N - 1) {
      image(backs, x, y, w, h * 1.1, OFFSETX + 860, 1092 + 622, 225, H - 1);
    }
  }
  return showIndicator(heap, x, indexOf.call(HEAPS, heap) >= 0 ? y - dy : y);
};

display = function display(board) {
  var dy, heap, l, len, len1, len2, m, n, o, x, y;
  background(0, 128, 0);
  showInfo();
  textAlign(CENTER, TOP);
  for (y = l = 0, len = ACES.length; l < len; y = ++l) {
    heap = ACES[y];
    showHeap(board, heap, 8, y, 0);
  }
  for (x = m = 0, len1 = HEAPS.length; m < len1; x = ++m) {
    heap = HEAPS[x];
    n = calcAntal(board[heap]);
    dy = n === 0 ? 0 : min(h / 4, 2 * h / (n - 1));
    showHeap(board, heap, x, 0, dy);
  }
  for (x = o = 0, len2 = PANEL.length; o < len2; x = ++o) {
    heap = PANEL[x];
    showHeap(board, heap, x, 3, 0);
  }
  noStroke();
  return showDialogue();
};

text3 = function text3(a, b, c, y) {};

showInfo = function showInfo() {
  var a, b, c, computer, human, i, l, len, len1, m, ref, time, totalComputer, totalHuman, totalTime, y;
  fill(64);
  textSize(0.2 * h);
  totalTime = 0;
  totalComputer = 0; //maxMoves
  totalHuman = 0; //hist.length
  ref = general.races;
  for (l = 0, len = ref.length; l < len; l++) {
    var _ref$l2 = _slicedToArray(ref[l], 3);

    time = _ref$l2[0];
    computer = _ref$l2[1];
    human = _ref$l2[2];

    totalTime += time;
    totalComputer += computer;
    totalHuman += human;
  }
  infoLines[1][2] = general.races.length;
  infoLines[2][1] = general.maxMoves;
  infoLines[3][1] = general.hist.length;
  infoLines[4][1] = general.timeUsed;
  infoLines[2][2] = totalComputer;
  infoLines[3][2] = totalHuman;
  infoLines[4][2] = totalTime;
  for (i = m = 0, len1 = infoLines.length; m < len1; i = ++m) {
    var _infoLines$i = _slicedToArray(infoLines[i], 3);

    a = _infoLines$i[0];
    b = _infoLines$i[1];
    c = _infoLines$i[2];

    if (i === 1 && !general.competition) {
      continue;
    }
    y = h * (2.2 + 0.2 * i);
    textAlign(LEFT, BOTTOM);
    text(a, 0.05 * w, y);
    textAlign(RIGHT, BOTTOM);
    text(b, 3 * w, y);
    if (general.competition) {
      text(c, 4 * w, y);
    }
  }
  if (!general.competition) {
    text("Hints: " + general.hintsUsed, 7.95 * w, 2.8 * h);
  }
  text("Level: " + general.level, 7.95 * w, 3 * h);
  textAlign(CENTER, CENTER);
  textSize(0.4 * h);
  stroke(0, 64, 0);
  noFill();
  return text('Generalens Tidsfördriv', 4 * w, 1.5 * h);
};

showDialogue = function showDialogue() {
  if (dialogues.length > 0) {
    return _.last(dialogues).show();
  }
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

  var _unpack11 = unpack(_.last(board[src]));

  var _unpack12 = _slicedToArray(_unpack11, 3);

  suit1 = _unpack12[0];
  under1 = _unpack12[1];
  over1 = _unpack12[2];

  var _unpack13 = unpack(_.last(board[dst]));

  var _unpack14 = _slicedToArray(_unpack13, 3);

  suit2 = _unpack14[0];
  under2 = _unpack14[1];
  over2 = _unpack14[2];

  if (suit1 === suit2 && 1 === Math.abs(over1 - over2)) {
    return true;
  }
  return false;
};

makeMove = function makeMove(board, src, dst, record) {
  var over, over1, over2, suit, suit2, under, under1, under2;

  var _unpack15 = unpack(board[src].pop());

  var _unpack16 = _slicedToArray(_unpack15, 3);

  suit = _unpack16[0];
  under1 = _unpack16[1];
  over1 = _unpack16[2];

  over = under1;
  under = over1;
  if (record) {
    general.hist.push([src, dst, 1 + abs(under1 - over1)]);
  }
  if (board[dst].length > 0) {
    var _unpack17 = unpack(board[dst].pop());

    var _unpack18 = _slicedToArray(_unpack17, 3);

    suit2 = _unpack18[0];
    under2 = _unpack18[1];
    over2 = _unpack18[2];

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

  var msg, res;
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

  var _unpack19 = unpack(b.pop());

  var _unpack20 = _slicedToArray(_unpack19, 3);

  suit = _unpack20[0];
  under = _unpack20[1];
  over = _unpack20[2];

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

// returns destination
oneClick = function oneClick(data, marked, board) {
  var sharp = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : false;

  var alternativeDsts, found, heap, holes, l, len, len1, m, ref;
  if (_.isEqual(data.lastMarked, marked)) {
    data.counter++;
  } else {
    data.counter = 0;
  }
  holes = [];
  found = false;
  for (l = 0, len = ACES.length; l < len; l++) {
    heap = ACES[l];
    if (legalMove(board, marked[0], heap)) {
      if (sharp) {
        makeMove(board, marked[0], heap, true);
      }
      found = true;
      return heap;
    }
  }
  if (!found) {
    // Går ej att flytta till något ess. 
    alternativeDsts = []; // för att kunna välja mellan flera via Undo
    for (m = 0, len1 = HEAPS.length; m < len1; m++) {
      heap = HEAPS[m];
      if (board[heap].length === 0) {
        if ((ref = marked[0], indexOf.call(PANEL, ref) >= 0) || calcAntal(board[marked[0]]) > 1) {
          holes.push(heap);
        }
      } else {
        if (legalMove(board, marked[0], heap)) {
          alternativeDsts.push(heap);
        }
      }
    }
    if (holes.length > 0) {
      alternativeDsts.push(holes[0]);
    }
    if (alternativeDsts.length > 0) {
      heap = alternativeDsts[data.counter % alternativeDsts.length];
      if (sharp) {
        makeMove(board, marked[0], heap, true);
      }
      data.lastMarked = marked;
      return heap;
    }
  }
  return marked[0];
};

// assert1.jpg
b1 = readBoard("cA|hA|sA|dA|h5|c3|s65|c2 d5||s3|d2 h6 d4|d3 h4|h2|c5|c4|h3|c6|s4|s2|d6");

assert(11, oneClick({
  lastMarked: 0,
  counter: 0
}, [4, 0], b1)); // hj5 to hj4

assert(5, oneClick({
  lastMarked: 0,
  counter: 0
}, [5, 0], b1)); // kl3 no move

assert(8, oneClick({
  lastMarked: 0,
  counter: 0
}, [6, 1], b1)); // sp5 to hole

assert(10, oneClick({
  lastMarked: 0,
  counter: 0
}, [7, 1], b1)); // ru5 to ru4

assert(8, oneClick({
  lastMarked: [7, 1],
  counter: 0
}, [7, 1], b1)); // ru5 to hole

assert(8, oneClick({
  lastMarked: 0,
  counter: 0
}, [8, -1], b1)); // hole click

assert(9, oneClick({
  lastMarked: 0,
  counter: 0
}, [9, 0], b1)); // sp3 no move

assert(7, oneClick({
  lastMarked: 0,
  counter: 0
}, [10, 2], b1)); // ru4 to ru5

assert(8, oneClick({
  lastMarked: [10, 2],
  counter: 0
}, [10, 2], b1)); // ru4 to hole

assert(7, oneClick({
  lastMarked: [10, 2],
  counter: 1
}, [10, 2], b1)); // ru4 to ru5

b1a = readBoard("cA|hA|sA|dA|h5|c3|s65|c2 d54||s3|d2 h6|d3 h4|h2|c5|c4|h3|c6|s4|s2|d6");

assert(4, oneClick({
  lastMarked: [10, 2],
  counter: 0
}, [10, 1], b1a)); // hj6 to hj5

assert(8, oneClick({
  lastMarked: [10, 1],
  counter: 0
}, [10, 1], b1a)); // hj6 to hole

assert(4, oneClick({
  lastMarked: 0,
  counter: 0
}, [11, 1], b1)); // hj4 to hj5

assert(8, oneClick({
  lastMarked: [11, 1],
  counter: 0
}, [11, 1], b1)); // hj4 to hole xxx

assert(1, oneClick({
  lastMarked: 0,
  counter: 0
}, [12, 0], b1)); // hj2 to A

assert(8, oneClick({
  lastMarked: 0,
  counter: 0
}, [13, 0], b1)); // kl5 to hole

assert(5, oneClick({
  lastMarked: 0,
  counter: 0
}, [14, 0], b1)); // kl4 to kl3

assert(8, oneClick({
  lastMarked: [14, 0],
  counter: 0
}, [14, 0], b1)); // kl4 to hole

assert(11, oneClick({
  lastMarked: 0,
  counter: 0
}, [15, 0], b1)); // hj3 to hj4

assert(8, oneClick({
  lastMarked: [15, 0],
  counter: 0
}, [15, 0], b1)); // hj3 to hole

assert(8, oneClick({
  lastMarked: 0,
  counter: 0
}, [16, 0], b1)); // kl6 to hole

assert(6, oneClick({
  lastMarked: 0,
  counter: 0
}, [17, 0], b1)); // sp4 to sp5

assert(9, oneClick({
  lastMarked: [17, 0],
  counter: 0
}, [17, 0], b1)); // sp4 to sp3

assert(8, oneClick({
  lastMarked: [17, 0],
  counter: 1
}, [17, 0], b1)); // sp4 to hole

assert(2, oneClick({
  lastMarked: 0,
  counter: 0
}, [18, 0], b1)); // sp2 to A

assert(7, oneClick({
  lastMarked: 0,
  counter: 0
}, [19, 0], b1)); // ru6 to ru5

assert(8, oneClick({
  lastMarked: [19, 0],
  counter: 0
}, [19, 0], b1)); // ru6 to hole


// assert2.jpg
b2 = readBoard("cA|hA|sA|dA|d5 h2 d3 h3|c7|c34|d4 h76|||s3 d6 c6|d7 c5 d2|c2|s4|s6|h5|s5|s7|s2|h4");

//assert 8, oneClick {lastMarked:0, marked:9, counter:0},b2 #hj6 to hole
hitGreen = function hitGreen(mx, my, mouseX, mouseY) {
  var n, seqs;
  if (my === 3) {
    return false;
  }
  seqs = board[mx + 4];
  n = calcAntal(seqs);
  if (n === 0) {
    return true;
  }
  return mouseY > h * (1 + 1 / 4 * (n - 1));
};

mousePressed = function mousePressed() {
  var dialogue, mx, my;
  if (!(0 < mouseX && mouseX < width)) {
    return;
  }
  if (!(0 < mouseY && mouseY < height)) {
    return;
  }
  mx = Math.floor(mouseX / w);
  my = Math.floor(mouseY / h);
  dialogue = _.last(dialogues);
  if (dialogues.length === 0 || !dialogue.execute(mouseX, mouseY)) {
    indicators = {};
    if (mx === 8 || hitGreen(mx, my, mouseX, mouseY)) {
      if (dialogues.length === 0) {
        menu1();
      } else {
        dialogues.pop();
      }
      display(board);
      return;
    }
    general.handle(mx, my);
  }
  return display(board);
};

//###### AI-section ########
findAllMoves = function findAllMoves(b) {
  var dst, holeUsed, l, len, len1, m, res, src;
  srcs = HEAPS.concat(PANEL);
  dsts = ACES.concat(HEAPS);
  res = [];
  for (l = 0, len = srcs.length; l < len; l++) {
    src = srcs[l];
    holeUsed = false;
    for (m = 0, len1 = dsts.length; m < len1; m++) {
      dst = dsts[m];
      if (src !== dst) {
        if (legalMove(b, src, dst)) {
          if (b[dst].length === 0) {
            if (holeUsed) {
              continue;
            }
            holeUsed = true;
          }
          res.push([src, dst]);
        }
      }
    }
  }
  return res;
};

expand = function expand(_ref3) {
  var _ref4 = _slicedToArray(_ref3, 4),
      aceCards = _ref4[0],
      level = _ref4[1],
      b = _ref4[2],
      path = _ref4[3];

  var dst, key, l, len, move, moves, newPath, res, src;
  res = [];
  moves = findAllMoves(b);
  for (l = 0, len = moves.length; l < len; l++) {
    move = moves[l];
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
  var dst, res, src;
  if (4 * N === countAceCards(board)) {
    return;
  }
  hintsUsed++;
  res = hintOne();
  if (res || general.hist.length === 0) {
    return;
  }
  indicators = {};

  var _$last3 = _.last(general.hist);

  var _$last4 = _slicedToArray(_$last3, 2);

  src = _$last4[0];
  dst = _$last4[1];

  indicators[src] = ['#f00', true];
  return indicators[dst] = ['#f00', false];
};

//undoMove hist.pop()
hintOne = function hintOne() {
  var cand, dst, hintTime, increment, key, nr, origBoard, path, src;
  hintTime = millis();
  aceCards = countAceCards(board);
  if (aceCards === N * 4) {
    return true;
  }
  cands = [];
  cands.push([aceCards, general.hist.length, board, // antal kort på ässen, antal drag, board
  []]);
  hash = {};
  key = dumpBoard(board);
  path = [];
  hash[key] = [path, board];
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

    //makeMove board,src,dst,true
    var _path$ = _slicedToArray(path[0], 2);

    src = _path$[0];
    dst = _path$[1];
    indicators = {};
    indicators[src] = ['#0f0', true];
    indicators[dst] = ['#0f0', false];
    print("hint: " + int(millis() - hintTime) + " ms");
    return true;
  } else {
    print('hint failed. Should never happen!');
    //print N,nr,cands.length,aceCards,_.size hash
    board = origBoard;
    return false;
  }
};

newGame = function newGame(lvl) {
  // 0..15
  var cand, increment, msg, nr;
  general.level = lvl;
  general.start = millis();
  msg = '';
  general.hist = [];
  while (true) {
    makeBoard(general.level);
    general.hintsUsed = 0;
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
    print(nr, cands.length);
    if (aceCards === N * 4) {
      print(JSON.stringify(dumpBoard(originalBoard)));
      board = cand[2];
      print(makeLink());
      printAutomaticSolution(hash, board);
      board = _.cloneDeep(originalBoard);
      print(int(millis() - general.start) + " ms");
      general.start = millis();
      general.maxMoves = int(cand[1]);
      return;
    }
  }
};

restart = function restart() {
  var msg;
  general.hist = [];
  board = _.cloneDeep(originalBoard);
  return msg = '';
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
  var dst, index, key, l, len, path, s, solution, src;
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
  for (index = l = 0, len = solution.length; l < len; index = ++l) {
    var _solution$index = _slicedToArray(solution[index], 2);

    path = _solution$index[0];
    b = _solution$index[1];

    var _$last5 = _.last(path);

    var _$last6 = _slicedToArray(_$last5, 2);

    src = _$last6[0];
    dst = _$last6[1];

    s += "\n" + index + ": " + prettyMove(src, dst, b) + " (" + src + " to " + dst + ")";
  }
  return print(s);
};

printManualSolution = function printManualSolution() {
  var antal, b, dst, index, l, len, ref, s, src;
  b = _.cloneDeep(originalBoard);
  s = 'Manual Solution:';
  ref = general.hist;
  for (index = l = 0, len = ref.length; l < len; index = ++l) {
    var _ref$index = _slicedToArray(ref[index], 3);

    src = _ref$index[0];
    dst = _ref$index[1];
    antal = _ref$index[2];

    s += "\n" + index + ": " + prettyMove(src, dst, b);
    makeMove(b, src, dst, false);
  }
  return print(s);
};
//# sourceMappingURL=sketch.js.map
