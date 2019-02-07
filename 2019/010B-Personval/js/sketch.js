'use strict';

// Generated by CoffeeScript 2.3.2
var PARTI_BETECKNING, PARTI_FÖRKORTNING, PERSONS_PER_PAGE, PERSON_AGE, PERSON_NAMN, PERSON_SEX, PERSON_UPPGIFT, VOTES, dbKommun, dbName, dbPartier, dbPersoner, dbTree, draw, fetchKommun, getKommun, getParameters, getTxt, gruppera, kommunkod, loadFile, länskod, makeFreq, mousePressed, pageStack, pages, preload, pressed, rensa, setup;

PERSONS_PER_PAGE = 16;

VOTES = 5;

PERSON_AGE = 0;

PERSON_SEX = 1; // M/K

PERSON_NAMN = 2;

PERSON_UPPGIFT = 3;

PARTI_FÖRKORTNING = 0; // C

PARTI_BETECKNING = 1; // Centerpartiet

kommunkod = null;

länskod = null;

dbName = {}; // T Områdesnamn

dbTree = {}; // A

dbPartier = {}; // B 

dbPersoner = {}; // C

dbKommun = {};

pages = {};

pageStack = new PageStack();

pressed = false;

makeFreq = function (words) {
  // personer är en lista
  var i, len, letter, res, word;
  res = {};
  words.sort();
  for (i = 0, len = words.length; i < len; i++) {
    word = words[i];
    letter = word[0];
    res[letter] = res[letter] === void 0 ? 1 : res[letter] + 1;
  }
  return res;
};

assert({
  a: 5,
  b: 9,
  c: 4
}, makeFreq('ababcbabcbcbabcbab'.split('')));

gruppera = function (words, n = 32) {
  // words är en lista med ord
  var count, group, letter, letters, m, res;
  letters = makeFreq(words);
  res = {};
  group = '';
  count = 0;
  for (letter in letters) {
    m = letters[letter];
    if (count + m <= n) {
      group += letter;
      count += m;
    } else {
      if (count > 0) {
        res[group] = count;
      }
      group = letter;
      count = m;
    }
  }
  if (count > 0) {
    res[group] = count;
  }
  return res;
};

assert({
  abc: 18
}, gruppera('cababbabcbcbabcbab'.split('')));

assert({
  AB: 7,
  C: 5,
  D: 9
}, gruppera('DBDCDADBDADCDBDADCBCC'.split(''), 8));

assert({
  abcghij: 16,
  klmrswå: 11
}, gruppera('aaaabbbbcghiijjjkkllmmrrswå'.split(''), 16));

rensa = function () {
  pages.rlk.selectedPersons = {
    R: [],
    L: [],
    K: []
  };
  pages.rlk.sbuttons = [];
  pages.rlk.selected = null;
  pages.partier.clear();
  pages.letters.clear();
  pages.personer.clear();
  pages.rlk.qr = '';
  return pages.rlk.start = new Date().getTime();
};

getParameters = function (h = window.location.href) {
  var arr, f;
  h = decodeURI(h);
  arr = h.split('?');
  if (arr.length !== 2) {
    return {};
  }
  if (arr[1] === '') {
    return {};
  }
  return _.object(function () {
    var i, len, ref, results;
    ref = arr[1].split('&');
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      f = ref[i];
      results.push(f.split('='));
    }
    return results;
  }());
};

loadFile = function (filePath) {
  var result, xmlhttp;
  result = null;
  xmlhttp = new XMLHttpRequest();
  xmlhttp.open("GET", filePath, false);
  xmlhttp.send();
  if (xmlhttp.status === 200) {
    result = xmlhttp.responseText;
  }
  return result;
};

getTxt = function (rlk, filename) {
  var cells, data, i, len, line, lines;
  data = filename === 'data\\09.txt' ? '' : loadFile(filename); // Gotland har inget Landsting
  dbName[rlk] = '';
  dbTree[rlk] = {};
  dbPartier[rlk] = {};
  dbPersoner[rlk] = {};
  lines = data.split('\n');
  for (i = 0, len = lines.length; i < len; i++) {
    line = lines[i];
    line = line.trim();
    cells = line.split('|');
    if (cells[0] === 'T') {
      // T|Arjeplog
      dbName[rlk] = cells[1];
    }
    if (cells[0] === 'A') {
      // kandidaturer # A|3|208509|208510|208511|208512|208513|208514
      dbTree[rlk][cells[1]] = cells.slice(2);
    }
    if (cells[0] === 'B') {
      // partier # B|4|C|Centerpartiet
      dbPartier[rlk][cells[1]] = cells.slice(2);
    }
    if (cells[0] === 'C') {
      // personer # C|10552|53|K|Britta Flinkfeldt|53 år, Arjeplog
      dbPersoner[rlk][cells[1]] = cells.slice(2);
    }
  }
  return print('getTxt', rlk, filename, data.length, _.size(dbPersoner[rlk]));
};

getKommun = function (filename) {
  var cells, data, i, kod, len, line, lines, namn;
  data = loadFile(filename);
  dbKommun = {};
  lines = data.split('\n');
  for (i = 0, len = lines.length; i < len; i++) {
    line = lines[i];
    line = line.trim();
    cells = line.split('|');
    kod = cells[0];
    namn = cells[1];
    if (kod.length === 4) {
      dbKommun[kod] = namn;
    }
  }
  return print('getKommun', _.size(dbKommun));
};

fetchKommun = function (kommun) {
  // t ex '0180'
  var start;
  start = new Date().getTime();
  if (länskod !== kommun.slice(0, 2)) {
    länskod = kommun.slice(0, 2);
    getTxt('L', `data\\${länskod}.txt`);
  }
  if (kommunkod !== kommun) {
    kommunkod = kommun;
    getTxt('K', `data\\${kommunkod}.txt`);
  }
  pages.rlk.buttons[1].title = dbName.L;
  pages.rlk.buttons[2].title = dbName.K;
  return print('time', new Date().getTime() - start);
};

preload = function () {
  var kommun;
  ({ kommun } = getParameters());
  if (!kommun) {
    kommun = '0180';
  }
  kommunkod = kommun;
  länskod = kommunkod.slice(0, 2);
  getTxt('R', 'data\\00.txt');
  getTxt('L', `data\\${länskod}.txt`);
  getTxt('K', `data\\${kommunkod}.txt`);
  return getKommun('data\\omraden.txt');
};

setup = function () {
  var gap, h, w;
  createCanvas(windowWidth, windowHeight - 1);
  sc();
  textAlign(CENTER, CENTER);
  textSize(20);
  w = width;
  h = height;
  gap = 0.002 * w;
  pages.rlk = new RLKPage(0, 0, 0.36 * w - gap, h);
  pages.partier = new PartiPage(0.36 * w, 0, 0.18 * w - gap, h);
  pages.letters = new LetterPage(0.54 * w, 0, 0.10 * w - gap, h);
  pages.personer = new PersonPage(0.64 * w, 0, 0.36 * w - gap, h);
  pages.kommun = new KommunPage(0.05 * w, 0.05 * h, 0.9 * w - gap, 0.9 * h);
  pages.utskrift = new UtskriftPage(0, 0, w, h);
  pageStack.push(pages.partier);
  pageStack.push(pages.letters);
  pageStack.push(pages.personer);
  pageStack.push(pages.rlk);
  pages.utskrift.modal = true;
  pages.kommun.modal = true;
  pages.rlk.buttons[1].title = dbName.L;
  pages.rlk.buttons[2].title = dbName.K;
  return print(_.keys(pages));
};

draw = function () {
  bg(0);
  return pageStack.draw();
};

mousePressed = function () {
  return pageStack.mousePressed();
};
//# sourceMappingURL=sketch.js.map
